//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/legacy(LightMapUnity_Matcap_AddLight)" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
[MHYHeaderBox(MATCAP)] _MatcapMaskMap ("MatcapMask Map", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
[MHYHeaderBox(LIGHTMAP)] [Toggle(_LIGHTMAPCOLOR_ON)] _EnableLightmapColor ("Enable LightmapColor Change", Float) = 0
_LightmapColorScale ("LightmapColorScale", Range(0, 4)) = 1.85
_LightmapColorIns ("LightmapColorIns", Range(0, 2)) = 0.9
_LightmapColorChange ("LightmapColorChange (RGB)", 2D) = "white" { }
_LightmapColorLerp ("LightmapColorLerp", Range(0, 1)) = 1
[MHYHeaderBox(ADDLIGHT)] _AdditiveLightPower ("Additive Light Power", Range(0.1, 5)) = 1
_AdditiveLightIntensity ("Additive Light Intensity", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 7776
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
uniform 	vec4 _MainMaps_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat18;
bool u_xlatb18;
float u_xlat20;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat0.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb18 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb18){
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * (-u_xlat5.xy);
        u_xlat18 = u_xlat5.x * _FogTune;
        u_xlat18 = u_xlat18 * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat18 = (-u_xlat18) + 1.0;
        u_xlat18 = u_xlat18 * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat18 = u_xlat5.y * 1.44269502;
        u_xlat18 = exp2(u_xlat18);
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    } else {
        u_xlat5.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat5.xyz;
        u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat5.xyz;
        u_xlat5.xyz = u_xlat5.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat18 = sqrt(u_xlat18);
        u_xlat18 = u_xlat18 + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.0);
        u_xlat5.xy = vec2(u_xlat18) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xy = u_xlat5.xy * vec2(500.0, 1000.0);
        u_xlat18 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat18 = max(u_xlat18, 0.100000001);
        u_xlat5.xy = u_xlat5.yx / vec2(u_xlat18);
        u_xlat18 = u_xlat5.y * _FogEffectLimit;
        u_xlat20 = _FogEffectStart * _FogTune;
        u_xlat18 = max(u_xlat18, u_xlat20);
        u_xlat3.w = min(u_xlat18, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat18 = (-u_xlat5.x) + 1.0;
        u_xlat5.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat18) * u_xlat5.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat3;
    //ENDIF
    }
    gl_Position = u_xlat1;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat1.zw;
    u_xlat1.x = u_xlat2.z;
    u_xlat1.y = u_xlat4.x;
    u_xlat1.z = u_xlat0.x;
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = u_xlat2.x;
    u_xlat1.y = u_xlat4.y;
    u_xlat1.z = u_xlat0.y;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    u_xlat0.x = u_xlat2.y;
    u_xlat0.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
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
uniform 	vec4 _MainMaps_ST;
uniform 	vec4 _PropertyLightmapTexTS;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_13;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _PropertyLightmapTexTS.xy + _PropertyLightmapTexTS.zw;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD3 = u_xlat0;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.yzx;
    u_xlat2.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat1.yzx * u_xlat2.yzx + (-u_xlat16_3.xyz);
    u_xlat4.xyz = u_xlat16_3.xyz * in_TANGENT0.www;
    u_xlat5.y = u_xlat4.x;
    u_xlat5.x = u_xlat2.z;
    u_xlat5.z = u_xlat1.x;
    vs_TEXCOORD4.xyz = u_xlat5.xyz;
    u_xlat1.x = u_xlat2.y;
    u_xlat2.z = u_xlat1.y;
    u_xlat2.y = u_xlat4.y;
    u_xlat1.y = u_xlat4.z;
    vs_TEXCOORD6.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat21) + 2.0;
    u_xlat16_3.x = u_xlat21 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_3.x = (u_xlatb22) ? u_xlat9.x : 1.0;
    u_xlat22 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
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
    u_xlat16_3.x = u_xlat22 * u_xlat16_3.x;
    u_xlat22 = min(u_xlat16_3.x, _HeigtFogColBase3.w);
    u_xlat9.x = (-u_xlat22) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat9.xxx;
    u_xlat3.w = u_xlat21 * u_xlat9.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat22) + u_xlat1.xyz;
    u_xlat16_6 = (-u_xlat7.x) + 2.0;
    u_xlat16_6 = u_xlat7.x * u_xlat16_6;
    u_xlat1.xyz = vec3(u_xlat16_6) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_6 = (u_xlatb14) ? u_xlat21 : 1.0;
    u_xlat14 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat14 * u_xlat16_6;
    u_xlat16_6 = exp2((-u_xlat16_6));
    u_xlat16_6 = min(u_xlat16_6, 1.0);
    u_xlat16_6 = (-u_xlat16_6) + 1.0;
    u_xlat16_13 = (-u_xlat0.x) + 2.0;
    u_xlat16_13 = u_xlat0.x * u_xlat16_13;
    u_xlat0.x = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_6 = u_xlat0.x * u_xlat16_6;
    u_xlat0.x = min(u_xlat16_6, _HeigtFogColBase2.w);
    u_xlat14 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat14) * u_xlat1.xyz;
    u_xlat2.w = u_xlat14 * u_xlat7.x;
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
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LOD_FADE_CROSSFADE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" "_LightMap_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/AddLight/ADDLIGHT"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}