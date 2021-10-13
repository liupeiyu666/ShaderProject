//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Terrain" {
Properties {
[MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
[MHYHeaderBox(MAPS)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Control Tex (RGBA)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _Splat0Tex ("Splat0 Tex (RGB)", 2D) = "black" { }
[MHYTextureScaleOffset] _Splat0Tex_ST ("Splat0Tex_ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _Splat1Tex ("Splat1 Tex (RGB)", 2D) = "black" { }
[MHYTextureScaleOffset] _Splat1Tex_ST ("Splat1Tex_ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _Splat2Tex ("Splat2 Tex (RGB)", 2D) = "black" { }
[MHYTextureScaleOffset] _Splat2Tex_ST ("Splat2Tex_ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _Splat3Tex ("Splat3 Tex (RGB)", 2D) = "black" { }
[MHYTextureScaleOffset] _Splat3Tex_ST ("Splat3Tex_ST", Vector) = (1,1,0,0)
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (0,0,0,0)
_ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[MHYHeaderBox(LIGHTING)] _BloomIntensity ("Bloom Intensity", Range(0, 50)) = 1
_LightMapIntensity ("Light Map Intensity", Range(0, 5)) = 1.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 43935
Program "vp" {
SubProgram "gles3 hw_tier00 " {
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
uniform 	mediump float _FogTune;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * u_xlat16_5.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * u_xlat16_5.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * u_xlat16_5.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * u_xlat16_5.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * u_xlat16_5.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_6.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_4.xyz = (-u_xlat16_4.xyz) * u_xlat16_5.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_4.xyz + u_xlat16_6.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_22;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_22;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_22;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_22;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_22;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
lowp vec3 u_xlat10_1;
lowp vec3 u_xlat10_2;
lowp vec4 u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump float u_xlat16_22;
void main()
{
    u_xlat10_0.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_1.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_2.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * u_xlat10_3.yyy;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat10_3.xxx + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.zzz + u_xlat16_4.xyz;
    u_xlat10_0.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_4.xyz = u_xlat10_0.xyz * u_xlat10_3.www + u_xlat16_4.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * _Color.xyz;
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_5.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_5.xyz = u_xlat16_5.xyz * _ShadowColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat16_5.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_4.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
lowp vec3 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_25;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_8.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8){
        u_xlat8.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_8.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat8.xy).x;
        u_xlat16_25 = u_xlat10_8.x;
    } else {
        u_xlat16_25 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_30 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat16_25 = (-u_xlat16_30) * u_xlat16_25 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = (-u_xlat16_6.xyz) * u_xlat16_1.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_7.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
lowp vec3 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_25;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_8.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8){
        u_xlat8.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_8.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat8.xy).x;
        u_xlat16_25 = u_xlat10_8.x;
    } else {
        u_xlat16_25 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_30 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat16_25 = (-u_xlat16_30) * u_xlat16_25 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = (-u_xlat16_6.xyz) * u_xlat16_1.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_7.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
lowp vec3 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_25;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_8.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8){
        u_xlat8.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_8.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat8.xy).x;
        u_xlat16_25 = u_xlat10_8.x;
    } else {
        u_xlat16_25 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_30 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat16_25 = (-u_xlat16_30) * u_xlat16_25 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = (-u_xlat16_6.xyz) * u_xlat16_1.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_7.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
lowp vec3 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_25;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_8.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8){
        u_xlat8.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_8.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat8.xy).x;
        u_xlat16_25 = u_xlat10_8.x;
    } else {
        u_xlat16_25 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_30 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat16_25 = (-u_xlat16_30) * u_xlat16_25 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = (-u_xlat16_6.xyz) * u_xlat16_1.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_7.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
lowp vec3 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_25;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_8.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8){
        u_xlat8.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_8.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat8.xy).x;
        u_xlat16_25 = u_xlat10_8.x;
    } else {
        u_xlat16_25 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_30 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat16_25 = (-u_xlat16_30) * u_xlat16_25 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = (-u_xlat16_6.xyz) * u_xlat16_1.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_7.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
vec3 u_xlat8;
float u_xlat13;
float u_xlat18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    u_xlat2.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat2.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    u_xlat3.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat8.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat3.w = u_xlat8.x * 0.5;
    vs_TEXCOORD2.xy = u_xlat3.zz + u_xlat3.xw;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    vs_TEXCOORD3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb3 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb3){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.x = u_xlat3.x * _FogTune;
        u_xlat3.x = u_xlat3.x * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat13, u_xlat3.x);
        u_xlat4.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.y * 1.44269502;
        u_xlat3.x = exp2(u_xlat3.x);
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat3.x = sqrt(u_xlat3.x);
        u_xlat3.x = u_xlat3.x + (-_FogStartDistance);
        u_xlat3.x = max(u_xlat3.x, 0.0);
        u_xlat3.xy = u_xlat3.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat13 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat13 = max(u_xlat13, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat13);
        u_xlat8.x = u_xlat3.y * _FogEffectLimit;
        u_xlat13 = _FogEffectStart * _FogTune;
        u_xlat8.x = max(u_xlat13, u_xlat8.x);
        u_xlat4.w = min(u_xlat8.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat8.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.xxx * u_xlat8.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    gl_Position = u_xlat0;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    vs_TEXCOORD2.zw = u_xlat0.zw;
    vs_TEXCOORD4 = u_xlat1;
    vs_TEXCOORD5 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec2 u_xlat8;
lowp vec3 u_xlat10_8;
bool u_xlatb8;
mediump float u_xlat16_25;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_8.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_8.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb8 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb8){
        u_xlat8.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_8.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat8.xy).x;
        u_xlat16_25 = u_xlat10_8.x;
    } else {
        u_xlat16_25 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_30 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_30 = min(max(u_xlat16_30, 0.0), 1.0);
#else
    u_xlat16_30 = clamp(u_xlat16_30, 0.0, 1.0);
#endif
    u_xlat16_25 = (-u_xlat16_25) + 1.0;
    u_xlat16_25 = (-u_xlat16_30) * u_xlat16_25 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_25) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_7.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_1.xyz = (-u_xlat16_6.xyz) * u_xlat16_1.xyz + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat16_7.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_22;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_7.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb7 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb7){
        u_xlat7.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_7.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat7.xy).x;
        u_xlat16_22 = u_xlat10_7.x;
    } else {
        u_xlat16_22 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_27 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_22 = (-u_xlat16_27) * u_xlat16_22 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_22;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_7.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb7 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb7){
        u_xlat7.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_7.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat7.xy).x;
        u_xlat16_22 = u_xlat10_7.x;
    } else {
        u_xlat16_22 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_27 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_22 = (-u_xlat16_27) * u_xlat16_22 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainMaps_ST;
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat12 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat12 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    vs_TEXCOORD3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_22;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_7.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb7 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb7){
        u_xlat7.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_7.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat7.xy).x;
        u_xlat16_22 = u_xlat10_7.x;
    } else {
        u_xlat16_22 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_27 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_22 = (-u_xlat16_27) * u_xlat16_22 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_22;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_7.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb7 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb7){
        u_xlat7.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_7.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat7.xy).x;
        u_xlat16_22 = u_xlat10_7.x;
    } else {
        u_xlat16_22 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_27 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_22 = (-u_xlat16_27) * u_xlat16_22 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_22;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_7.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb7 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb7){
        u_xlat7.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_7.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat7.xy).x;
        u_xlat16_22 = u_xlat10_7.x;
    } else {
        u_xlat16_22 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_27 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_22 = (-u_xlat16_27) * u_xlat16_22 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
uniform 	mediump vec4 _Splat0Tex_ST;
uniform 	mediump vec4 _Splat1Tex_ST;
uniform 	mediump vec4 _Splat2Tex_ST;
uniform 	mediump vec4 _Splat3Tex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec4 in_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_TEXCOORD5;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainMaps_ST.xy + _MainMaps_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    vs_TEXCOORD1 = in_COLOR0;
    u_xlat15 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat15 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD2.zw = u_xlat1.zw;
    vs_TEXCOORD2.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    vs_TEXCOORD3.xyz = vec3(u_xlat15) * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat0Tex_ST.xy + _Splat0Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat1Tex_ST.xy + _Splat1Tex_ST.zw;
    vs_TEXCOORD4 = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _Splat2Tex_ST.xy + _Splat2Tex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _Splat3Tex_ST.xy + _Splat3Tex_ST.zw;
    vs_TEXCOORD5 = u_xlat1;
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
uniform 	float _ReceiveDynamicShadow;
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec3 _ShadowColor;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _ShadowIntegration;
uniform 	mediump vec3 _LightingColor;
uniform 	mediump vec4 _Color;
uniform 	mediump float _BloomIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Splat0Tex;
uniform lowp sampler2D _Splat1Tex;
uniform lowp sampler2D _Splat2Tex;
uniform lowp sampler2D _Splat3Tex;
uniform lowp sampler2D _DynamicSceneShadowVolumeBuffer;
uniform mediump sampler2D unity_Lightmap;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
in mediump vec4 vs_TEXCOORD5;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec4 u_xlat10_2;
lowp vec3 u_xlat10_3;
lowp vec3 u_xlat10_4;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
vec2 u_xlat7;
lowp vec3 u_xlat10_7;
bool u_xlatb7;
mediump float u_xlat16_22;
mediump float u_xlat16_27;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.zw).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_7.xyz = texture(_Splat0Tex, vs_TEXCOORD4.xy).xyz;
    u_xlat10_3.xyz = texture(_Splat1Tex, vs_TEXCOORD4.zw).xyz;
    u_xlat10_4.xyz = texture(_Splat2Tex, vs_TEXCOORD5.xy).xyz;
    u_xlat10_5.xyz = texture(_Splat3Tex, vs_TEXCOORD5.zw).xyz;
    u_xlat16_6.xyz = u_xlat10_2.yyy * u_xlat10_3.xyz;
    u_xlat16_6.xyz = u_xlat10_7.xyz * u_xlat10_2.xxx + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_4.xyz * u_xlat10_2.zzz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = u_xlat10_5.xyz * u_xlat10_2.www + u_xlat16_6.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.5<_ReceiveDynamicShadow);
#else
    u_xlatb7 = 0.5<_ReceiveDynamicShadow;
#endif
    if(u_xlatb7){
        u_xlat7.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
        u_xlat10_7.x = texture(_DynamicSceneShadowVolumeBuffer, u_xlat7.xy).x;
        u_xlat16_22 = u_xlat10_7.x;
    } else {
        u_xlat16_22 = 1.0;
    //ENDIF
    }
    u_xlat16_1.xyz = u_xlat16_1.xyz * _ShadowColor.xyz;
    u_xlat16_27 = unity_Lightmap_HDR.x * u_xlat16_0.x + (-_ShadowIntegration);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_27 = min(max(u_xlat16_27, 0.0), 1.0);
#else
    u_xlat16_27 = clamp(u_xlat16_27, 0.0, 1.0);
#endif
    u_xlat16_22 = (-u_xlat16_22) + 1.0;
    u_xlat16_22 = (-u_xlat16_27) * u_xlat16_22 + 1.0;
    u_xlat16_6.xyz = u_xlat16_6.xyz * _Color.xyz;
    u_xlat16_1.xyz = vec3(u_xlat16_22) * u_xlat16_1.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vec3(_LightingColor.x, _LightingColor.y, _LightingColor.z);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_6.xyz;
    u_xlat16_22 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_22 = min(max(u_xlat16_22, 0.0), 1.0);
#else
    u_xlat16_22 = clamp(u_xlat16_22, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_22) + vs_COLOR1.xyz;
    SV_Target0.w = _BloomIntensity;
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
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
CustomEditor "MoleMoleEditor.CharacterAvatarShaderGUI"
}