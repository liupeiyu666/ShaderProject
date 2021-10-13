//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Scene_Crystals_Lightmap_DepthFade" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Albedo |RGB(base color)", 2D) = "white" { }
_ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
_EnvironmentLight ("Environment Light", Range(0, 2)) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
_ColorScale ("ColorScale", Range(0, 1)) = 0.4
_RefractTex ("Refraction Texture", Cube) = "" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
[MHYHeaderBox(EMISSION)] _EmissionMask ("Emission Mask", 2D) = "black" { }
[Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
_Emission ("Emission Color", Color) = (0,0,0,0.5)
_EmissionGIIntensity ("Emission GI Intensity", Range(0, 10)) = 2
[MHYHeaderBox(CUSTOMLIGHTMAP)] [Toggle(_LightMap_ON)] _EnableLightmapOn ("Enable Lightmap On", Float) = 1
_LightMapIntensity ("Light Map Intensity", Float) = 1
_SpecialState ("Special State", Float) = 0
[MHYHeaderBox(DEPTHFADE)] _DepthFadeColor ("DepthFadeColor", Color) = (0,0,0,0)
_DepthFadeDistance ("DepthFadeDistance", Range(0, 30)) = 0
_DepthFadeTexIntensity ("DepthFadeIntensity", Float) = 1
_DepthFadeTex ("DepthFadeTex", 2D) = "white" { }
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" }
  GpuProgramID 40945
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _FogColorNear;
uniform 	vec4 _FogColorFar;
uniform 	float _FogColorIntensity;
uniform 	float _FogIntensity;
uniform 	float _FogEffectStart;
uniform 	float _FogEffectLimit;
uniform 	float _FogStartDistance;
uniform 	float _FogEndDistance;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
uniform 	vec4 unity_LightmapST;
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
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = unity_Lightmap_HDR.xxx * u_xlat16_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat11;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    vs_TEXCOORD3.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    vs_TEXCOORD2 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
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
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6, u_xlat0.x);
        u_xlat2.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat6 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6 = max(u_xlat6, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat6);
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6, u_xlat3.x);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD4.xy = u_xlat0.zz + u_xlat0.xw;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * u_xlat16_0.xyz + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_3.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
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
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
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
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
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
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
float u_xlat4;
bool u_xlatb4;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3 = (-u_xlat12) + 2.0;
    u_xlat16_3 = u_xlat12 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat8.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat8.x = u_xlat8.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat8.x = min(max(u_xlat8.x, 0.0), 1.0);
#else
    u_xlat8.x = clamp(u_xlat8.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat8.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat8.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat0.x>=u_xlat8.x);
#else
    u_xlatb8 = u_xlat0.x>=u_xlat8.x;
#endif
    u_xlat12 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat13 = (-u_xlat12) + 2.0;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * _HeigtFogColDelta.w;
    u_xlat8.x = (u_xlatb8) ? u_xlat13 : u_xlat12;
    u_xlat8.x = log2(u_xlat8.x);
    u_xlat8.x = u_xlat8.x * _Mihoyo_FogColor.w;
    u_xlat8.x = exp2(u_xlat8.x);
    u_xlat8.x = min(u_xlat8.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat12 = u_xlat4 * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4);
#endif
    u_xlat16_3 = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat4 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat4 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
    u_xlat2.w = u_xlat4 * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat7;
mediump float u_xlat16_8;
mediump float u_xlat16_9;
float u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
bool u_xlatb16;
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
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2 = u_xlat0;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD4.zw = u_xlat1.zw;
    vs_TEXCOORD4.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat15) + 2.0;
    u_xlat16_3 = u_xlat15 * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat5.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat15 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat15 = u_xlat15 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat15 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16 = (-u_xlat15) + 2.0;
    u_xlat15 = u_xlat15 * u_xlat16;
    u_xlat16 = u_xlat15 * _HeigtFogColDelta3.w;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat0.x>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat0.x>=u_xlat2.x;
#endif
    u_xlat15 = (u_xlatb2) ? u_xlat16 : u_xlat15;
    u_xlat15 = log2(u_xlat15);
    u_xlat15 = u_xlat15 * _Mihoyo_FogColor3.w;
    u_xlat15 = exp2(u_xlat15);
    u_xlat15 = min(u_xlat15, _HeigtFogColBase3.w);
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat16 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat10 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat7.x = u_xlat16 * -1.44269502;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = (-u_xlat7.x) + 1.0;
    u_xlat7.x = u_xlat7.x / u_xlat16;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(0.00999999978<abs(u_xlat16));
#else
    u_xlatb16 = 0.00999999978<abs(u_xlat16);
#endif
    u_xlat16_3 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat7.x = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat7.xxx;
    u_xlat3.w = u_xlat15 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat16_4 = (-u_xlat5.x) + 2.0;
    u_xlat16_4 = u_xlat5.x * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat7.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat5.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat5.x = u_xlat5.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat5.xxx * u_xlat7.xyz + u_xlat1.xyz;
    u_xlat5.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat15 = (-u_xlat5.x) + 2.0;
    u_xlat5.x = u_xlat15 * u_xlat5.x;
    u_xlat15 = u_xlat5.x * _HeigtFogColDelta2.w;
    u_xlat5.x = (u_xlatb2) ? u_xlat15 : u_xlat5.x;
    u_xlat5.x = log2(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _Mihoyo_FogColor2.w;
    u_xlat5.x = exp2(u_xlat5.x);
    u_xlat5.x = min(u_xlat5.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat5.xxx * u_xlat1.xyz;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ZBufferParams;
uniform 	float _Transparent;
uniform 	mediump vec4 _Color;
uniform 	vec4 _DepthFadeColor;
uniform 	float _DepthFadeDistance;
uniform 	vec4 _DepthFadeTex_ST;
uniform 	float _DepthFadeTexIntensity;
uniform 	mediump float _ReflectionStrength;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _ColorScale;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec4 _Emission;
uniform 	int _UseSet;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _RefractTex;
uniform lowp sampler2D _EmissionMask;
uniform lowp sampler2D _PropertyLightmapTex;
uniform lowp sampler2D _DepthFadeTex;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_16;
float u_xlat17;
mediump float u_xlat16_18;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat16_1.x = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat16_1.x = (-u_xlat16_1.x) + 1.0;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = min(u_xlat16_1.x, 1.0);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.x;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _FresnelParams.y;
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlat16_1.x = u_xlat16_1.x + _FresnelParams.z;
    u_xlat0.xyz = vs_TEXCOORD2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = vs_TEXCOORD3.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_RefractTex, u_xlat0.xyz).xyz;
    u_xlat10_2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * _Color.xyz;
    u_xlat16_6.xyz = u_xlat10_0.xyz * vec3(_ReflectionStrength) + u_xlat16_6.xyz;
    u_xlat0.x = float(_UseSet);
    u_xlat5.xy = (-vs_TEXCOORD0.xy) + vs_TEXCOORD1.xy;
    u_xlat0.xy = u_xlat0.xx * u_xlat5.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.xyz = texture(_EmissionMask, u_xlat0.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _Emission.xyz;
    u_xlat16_18 = u_xlat10_0.x + _Color.w;
    u_xlat16_18 = u_xlat16_18 * _FresnelParams.w;
    u_xlat16_18 = min(u_xlat16_18, 1.0);
    SV_Target0.w = u_xlat16_18 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_3.xyz = u_xlat16_3.xyz * _Emission.www;
    u_xlat16_6.xyz = u_xlat16_3.xyz * vec3(2.0, 2.0, 2.0) + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat10_2.xyz + u_xlat16_6.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_ColorScale);
    u_xlat10_0.xyz = texture(_PropertyLightmapTex, vs_TEXCOORD0.zw).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.xyz = vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) * u_xlat16_0.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
    u_xlat16_16 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_16 = min(max(u_xlat16_16, 0.0), 1.0);
#else
    u_xlat16_16 = clamp(u_xlat16_16, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_16) + vs_COLOR1.xyz;
    u_xlat0.xy = vs_TEXCOORD0.xy * _DepthFadeTex_ST.xy + _DepthFadeTex_ST.zw;
    u_xlat10_0.x = texture(_DepthFadeTex, u_xlat0.xy).x;
    u_xlat5.xyz = _DepthFadeColor.xyz * vec3(_DepthFadeTexIntensity);
    u_xlat0.xyz = u_xlat5.xyz * u_xlat10_0.xxx + u_xlat16_1.xyz;
    u_xlat2.xyz = (-u_xlat0.xyz) + u_xlat16_1.xyz;
    u_xlat4.xyz = vs_TEXCOORD4.zxy / vs_TEXCOORD4.www;
    u_xlat10_15 = texture(_CustomDepthTexture, u_xlat4.yz).x;
    u_xlat17 = u_xlat4.x * 0.5 + 0.5;
    u_xlat17 = _ZBufferParams.z * u_xlat17 + _ZBufferParams.w;
    u_xlat17 = float(1.0) / u_xlat17;
    u_xlat15 = _ZBufferParams.z * u_xlat10_15 + _ZBufferParams.w;
    u_xlat15 = float(1.0) / u_xlat15;
    u_xlat15 = (-u_xlat17) + u_xlat15;
    u_xlat15 = u_xlat15 / _DepthFadeDistance;
    u_xlat15 = min(abs(u_xlat15), 1.0);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat2.xyz + u_xlat0.xyz;
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
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Meta/META_ADD"
}
CustomEditor "MoleMoleEditor.CharacterAvatarShaderGUI"
}