//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/AirEffect_LightMap_Reflect_Detail" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_MainColor ("Main Color", Color) = (1,1,1,1)
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
[MHYSingleLineTextureNoScaleOffset] _ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
[MHYHeaderBox(SeprateAlpha)] [Toggle(_Enable_Seprate_Alpha)] _EnableSperateAlpha ("Enable Seprate Alpha", Float) = 1
_MainTex_Alpha ("R(Alpha)", 2D) = "white" { }
[MHYHeaderBox(Reflect)] _EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
[MHYHeaderBox(Fresnel)] [Toggle(_Enable_Fresnel)] _EnableFresnel ("Enable Fresnel", Float) = 1
_fresnelCol ("FresnelCol", Color) = (1,1,1,1)
_fresnelBase ("FresnelBase", Range(0, 4)) = 1
_fresnelScale ("FresnelScale", Range(0, 4)) = 1
_fresnelIndensity ("FresnelIndensity", Range(0, 5)) = 5
[MHYHeaderBox(Detail)] _DetailTex ("Second Texture", 2D) = "black" { }
_DetailIntensity ("Detail Intensity", Float) = 1
_DetailSpeed ("Detail Speed", Float) = 0
_FogTune ("Fog Tune", Range(0, 1)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 36055
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat12 = _Time.x * _DetailSpeed;
    u_xlat12 = fract(u_xlat12);
    u_xlat1.z = u_xlat12 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat5.xz = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat12 = u_xlat5.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat5.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat5.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat5.z * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
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
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD1.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_14;
float u_xlat24;
lowp float u_xlat10_24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
    u_xlat16_7.xyz = (-u_xlat16_14.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_7.xyz + u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat12 = _Time.x * _DetailSpeed;
    u_xlat12 = fract(u_xlat12);
    u_xlat1.z = u_xlat12 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat5.xz = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat12 = u_xlat5.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat5.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat5.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat5.z * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
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
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD1.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_14;
float u_xlat24;
lowp float u_xlat10_24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
    u_xlat16_7.xyz = (-u_xlat16_14.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_7.xyz + u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat12 = _Time.x * _DetailSpeed;
    u_xlat12 = fract(u_xlat12);
    u_xlat1.z = u_xlat12 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat5.xz = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat12 = u_xlat5.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat5.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat5.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat5.z * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
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
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD1.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_14;
float u_xlat24;
lowp float u_xlat10_24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
    u_xlat16_7.xyz = (-u_xlat16_14.xyz) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_7.xyz + u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat12 = _Time.x * _DetailSpeed;
    u_xlat12 = fract(u_xlat12);
    u_xlat1.z = u_xlat12 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat5.xz = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat12 = u_xlat5.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat5.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat5.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat5.z * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
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
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD1.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_14;
float u_xlat24;
lowp float u_xlat10_24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
    u_xlat16_7.xyz = (-u_xlat16_14.xyz) + vs_COLOR1.xyz;
    u_xlat16_14.xyz = vs_COLOR1.www * u_xlat16_7.xyz + u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_14.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_14.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_14.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat12 = _Time.x * _DetailSpeed;
    u_xlat12 = fract(u_xlat12);
    u_xlat1.z = u_xlat12 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat5.xz = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat12 = u_xlat5.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat5.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat5.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat5.z * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
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
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD1.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_14;
float u_xlat24;
lowp float u_xlat10_24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
    u_xlat16_7.xyz = (-u_xlat16_14.xyz) + vs_COLOR1.xyz;
    u_xlat16_14.xyz = vs_COLOR1.www * u_xlat16_7.xyz + u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_14.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_14.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_14.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD2.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat12 = _Time.x * _DetailSpeed;
    u_xlat12 = fract(u_xlat12);
    u_xlat1.z = u_xlat12 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat5.xz = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat12 = u_xlat5.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat5.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat5.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat5.z * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
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
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat0.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD1.xy = u_xlat1.xz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_14;
float u_xlat24;
lowp float u_xlat10_24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
    u_xlat16_7.xyz = (-u_xlat16_14.xyz) + vs_COLOR1.xyz;
    u_xlat16_14.xyz = vs_COLOR1.www * u_xlat16_7.xyz + u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_14.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_14.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_14.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    vs_TEXCOORD2.xyz = (-u_xlat0.xwy) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xwy) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat13 = _Time.x * _DetailSpeed;
    u_xlat13 = fract(u_xlat13);
    u_xlat1.z = u_xlat13 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb5 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb5){
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat5.x = u_xlat5.x * _FogTune;
        u_xlat5.x = u_xlat5.x * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat5.x = u_xlat5.x * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat5.x = max(u_xlat5.x, u_xlat2.x);
        u_xlat2.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat5.x = u_xlat5.z * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * vec2(500.0, 1000.0);
        u_xlat2.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat5.xz = u_xlat5.zx / u_xlat2.xx;
        u_xlat13 = u_xlat5.z * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat13 = max(u_xlat13, u_xlat2.x);
        u_xlat2.w = min(u_xlat13, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat5.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat5.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_UWFogDistStart);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.xz = u_xlat5.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
    u_xlat5.xz = u_xlat5.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat5.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD1.xy = u_xlat1.xz;
    vs_TEXCOORD5.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
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
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD5.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD5.z<_WaterPlaneHeight;
#endif
    u_xlat8.x = (-vs_TEXCOORD5.z) + _WaterPlaneHeight;
    u_xlat16 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat8.x = u_xlat8.x / u_xlat16;
    u_xlat8.x = max(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat8.x + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.99000001<vs_TEXCOORD5.y);
#else
    u_xlatb24 = 0.99000001<vs_TEXCOORD5.y;
#endif
    u_xlat8.x = (-u_xlat8.x) * _UWHeightRatio + 1.0;
    u_xlat8.x = u_xlat8.x * vs_TEXCOORD5.y;
    u_xlat8.x = max(u_xlat8.x, _UWCriticalRange);
    u_xlat8.x = min(u_xlat8.x, 1.0);
    u_xlat16_7 = (u_xlatb24) ? u_xlat8.x : vs_TEXCOORD5.y;
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD5.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat9.xyz) + u_xlat16_14.xyz;
    u_xlat9.xyz = vec3(u_xlat16_7) * u_xlat2.xyz + u_xlat9.xyz;
    u_xlat2.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat9.xyz + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat8.xyz : u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    vs_TEXCOORD2.xyz = (-u_xlat0.xwy) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xwy) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat13 = _Time.x * _DetailSpeed;
    u_xlat13 = fract(u_xlat13);
    u_xlat1.z = u_xlat13 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb5 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb5){
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat5.x = u_xlat5.x * _FogTune;
        u_xlat5.x = u_xlat5.x * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat5.x = u_xlat5.x * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat5.x = max(u_xlat5.x, u_xlat2.x);
        u_xlat2.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat5.x = u_xlat5.z * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * vec2(500.0, 1000.0);
        u_xlat2.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat5.xz = u_xlat5.zx / u_xlat2.xx;
        u_xlat13 = u_xlat5.z * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat13 = max(u_xlat13, u_xlat2.x);
        u_xlat2.w = min(u_xlat13, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat5.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat5.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_UWFogDistStart);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.xz = u_xlat5.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
    u_xlat5.xz = u_xlat5.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat5.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD1.xy = u_xlat1.xz;
    vs_TEXCOORD5.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
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
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD5.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD5.z<_WaterPlaneHeight;
#endif
    u_xlat8.x = (-vs_TEXCOORD5.z) + _WaterPlaneHeight;
    u_xlat16 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat8.x = u_xlat8.x / u_xlat16;
    u_xlat8.x = max(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat8.x + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.99000001<vs_TEXCOORD5.y);
#else
    u_xlatb24 = 0.99000001<vs_TEXCOORD5.y;
#endif
    u_xlat8.x = (-u_xlat8.x) * _UWHeightRatio + 1.0;
    u_xlat8.x = u_xlat8.x * vs_TEXCOORD5.y;
    u_xlat8.x = max(u_xlat8.x, _UWCriticalRange);
    u_xlat8.x = min(u_xlat8.x, 1.0);
    u_xlat16_7 = (u_xlatb24) ? u_xlat8.x : vs_TEXCOORD5.y;
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD5.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat9.xyz) + u_xlat16_14.xyz;
    u_xlat9.xyz = vec3(u_xlat16_7) * u_xlat2.xyz + u_xlat9.xyz;
    u_xlat2.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat9.xyz + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat8.xyz : u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    vs_TEXCOORD2.xyz = (-u_xlat0.xwy) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xwy) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat13 = _Time.x * _DetailSpeed;
    u_xlat13 = fract(u_xlat13);
    u_xlat1.z = u_xlat13 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb5 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb5){
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat5.x = u_xlat5.x * _FogTune;
        u_xlat5.x = u_xlat5.x * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat5.x = u_xlat5.x * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat5.x = max(u_xlat5.x, u_xlat2.x);
        u_xlat2.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat5.x = u_xlat5.z * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * vec2(500.0, 1000.0);
        u_xlat2.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat5.xz = u_xlat5.zx / u_xlat2.xx;
        u_xlat13 = u_xlat5.z * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat13 = max(u_xlat13, u_xlat2.x);
        u_xlat2.w = min(u_xlat13, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat5.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat5.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_UWFogDistStart);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.xz = u_xlat5.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
    u_xlat5.xz = u_xlat5.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat5.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD1.xy = u_xlat1.xz;
    vs_TEXCOORD5.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
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
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD5.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD5.z<_WaterPlaneHeight;
#endif
    u_xlat8.x = (-vs_TEXCOORD5.z) + _WaterPlaneHeight;
    u_xlat16 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat8.x = u_xlat8.x / u_xlat16;
    u_xlat8.x = max(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat8.x + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.99000001<vs_TEXCOORD5.y);
#else
    u_xlatb24 = 0.99000001<vs_TEXCOORD5.y;
#endif
    u_xlat8.x = (-u_xlat8.x) * _UWHeightRatio + 1.0;
    u_xlat8.x = u_xlat8.x * vs_TEXCOORD5.y;
    u_xlat8.x = max(u_xlat8.x, _UWCriticalRange);
    u_xlat8.x = min(u_xlat8.x, 1.0);
    u_xlat16_7 = (u_xlatb24) ? u_xlat8.x : vs_TEXCOORD5.y;
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD5.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat9.xyz) + u_xlat16_14.xyz;
    u_xlat9.xyz = vec3(u_xlat16_7) * u_xlat2.xyz + u_xlat9.xyz;
    u_xlat2.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat9.xyz + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat8.xyz : u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    vs_TEXCOORD2.xyz = (-u_xlat0.xwy) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xwy) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat13 = _Time.x * _DetailSpeed;
    u_xlat13 = fract(u_xlat13);
    u_xlat1.z = u_xlat13 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb5 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb5){
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat5.x = u_xlat5.x * _FogTune;
        u_xlat5.x = u_xlat5.x * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat5.x = u_xlat5.x * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat5.x = max(u_xlat5.x, u_xlat2.x);
        u_xlat2.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat5.x = u_xlat5.z * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * vec2(500.0, 1000.0);
        u_xlat2.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat5.xz = u_xlat5.zx / u_xlat2.xx;
        u_xlat13 = u_xlat5.z * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat13 = max(u_xlat13, u_xlat2.x);
        u_xlat2.w = min(u_xlat13, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat5.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat5.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_UWFogDistStart);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.xz = u_xlat5.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
    u_xlat5.xz = u_xlat5.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat5.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD1.xy = u_xlat1.xz;
    vs_TEXCOORD5.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
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
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD5.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD5.z<_WaterPlaneHeight;
#endif
    u_xlat8.x = (-vs_TEXCOORD5.z) + _WaterPlaneHeight;
    u_xlat16 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat8.x = u_xlat8.x / u_xlat16;
    u_xlat8.x = max(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat8.x + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.99000001<vs_TEXCOORD5.y);
#else
    u_xlatb24 = 0.99000001<vs_TEXCOORD5.y;
#endif
    u_xlat8.x = (-u_xlat8.x) * _UWHeightRatio + 1.0;
    u_xlat8.x = u_xlat8.x * vs_TEXCOORD5.y;
    u_xlat8.x = max(u_xlat8.x, _UWCriticalRange);
    u_xlat8.x = min(u_xlat8.x, 1.0);
    u_xlat16_7 = (u_xlatb24) ? u_xlat8.x : vs_TEXCOORD5.y;
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD5.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat9.xyz) + u_xlat16_14.xyz;
    u_xlat9.xyz = vec3(u_xlat16_7) * u_xlat2.xyz + u_xlat9.xyz;
    u_xlat2.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat9.xyz + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (bool(u_xlatb0)) ? u_xlat8.xyz : u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_14.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_14.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_14.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    vs_TEXCOORD2.xyz = (-u_xlat0.xwy) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xwy) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat13 = _Time.x * _DetailSpeed;
    u_xlat13 = fract(u_xlat13);
    u_xlat1.z = u_xlat13 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb5 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb5){
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat5.x = u_xlat5.x * _FogTune;
        u_xlat5.x = u_xlat5.x * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat5.x = u_xlat5.x * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat5.x = max(u_xlat5.x, u_xlat2.x);
        u_xlat2.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat5.x = u_xlat5.z * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * vec2(500.0, 1000.0);
        u_xlat2.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat5.xz = u_xlat5.zx / u_xlat2.xx;
        u_xlat13 = u_xlat5.z * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat13 = max(u_xlat13, u_xlat2.x);
        u_xlat2.w = min(u_xlat13, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat5.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat5.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_UWFogDistStart);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.xz = u_xlat5.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
    u_xlat5.xz = u_xlat5.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat5.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD1.xy = u_xlat1.xz;
    vs_TEXCOORD5.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
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
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD5.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD5.z<_WaterPlaneHeight;
#endif
    u_xlat8.x = (-vs_TEXCOORD5.z) + _WaterPlaneHeight;
    u_xlat16 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat8.x = u_xlat8.x / u_xlat16;
    u_xlat8.x = max(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat8.x + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.99000001<vs_TEXCOORD5.y);
#else
    u_xlatb24 = 0.99000001<vs_TEXCOORD5.y;
#endif
    u_xlat8.x = (-u_xlat8.x) * _UWHeightRatio + 1.0;
    u_xlat8.x = u_xlat8.x * vs_TEXCOORD5.y;
    u_xlat8.x = max(u_xlat8.x, _UWCriticalRange);
    u_xlat8.x = min(u_xlat8.x, 1.0);
    u_xlat16_7 = (u_xlatb24) ? u_xlat8.x : vs_TEXCOORD5.y;
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD5.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat9.xyz) + u_xlat16_14.xyz;
    u_xlat9.xyz = vec3(u_xlat16_7) * u_xlat2.xyz + u_xlat9.xyz;
    u_xlat2.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat9.xyz + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (bool(u_xlatb0)) ? u_xlat8.xyz : u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_14.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_14.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_14.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	vec4 _DetailTex_ST;
uniform 	mediump float _FogTune;
uniform 	float _DetailSpeed;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb5;
float u_xlat13;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    vs_TEXCOORD3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    vs_TEXCOORD3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    vs_TEXCOORD2.xyz = (-u_xlat0.xwy) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    vs_TEXCOORD4.xyz = (-u_xlat0.xwy) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xy = in_TEXCOORD0.xy * _DetailTex_ST.xy + _DetailTex_ST.zw;
    u_xlat13 = _Time.x * _DetailSpeed;
    u_xlat13 = fract(u_xlat13);
    u_xlat1.z = u_xlat13 + u_xlat1.y;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb5 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb5){
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
        u_xlat5.x = u_xlat5.x * _FogTune;
        u_xlat5.x = u_xlat5.x * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat5.x = u_xlat5.x * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat5.x = max(u_xlat5.x, u_xlat2.x);
        u_xlat2.w = min(u_xlat5.x, _FogEffectLimit);
        u_xlat5.x = u_xlat5.z * 1.44269502;
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
        u_xlat5.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat5.x = sqrt(u_xlat5.x);
        u_xlat5.x = u_xlat5.x + (-_FogStartDistance);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.xz = u_xlat5.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat5.xz = u_xlat5.xz * vec2(500.0, 1000.0);
        u_xlat2.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat2.x = max(u_xlat2.x, 0.100000001);
        u_xlat5.xz = u_xlat5.zx / u_xlat2.xx;
        u_xlat13 = u_xlat5.z * _FogEffectLimit;
        u_xlat2.x = _FogEffectStart * _FogTune;
        u_xlat13 = max(u_xlat13, u_xlat2.x);
        u_xlat2.w = min(u_xlat13, _FogEffectLimit);
        u_xlat5.x = u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
        u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
        u_xlat5.x = (-u_xlat5.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat5.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat5.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat5.x = dot(u_xlat5.xz, u_xlat5.xz);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat5.x = u_xlat5.x + (-_UWFogDistStart);
    u_xlat5.x = max(u_xlat5.x, 0.0);
    u_xlat5.xz = u_xlat5.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat5.xz = u_xlat5.xz * (-u_xlat5.xz);
    u_xlat5.xz = u_xlat5.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat5.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD1.xy = u_xlat1.xz;
    vs_TEXCOORD5.xyz = u_xlat0.yzw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
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
uniform 	int _EnableSperateAlpha;
uniform 	int _EnableFresnel;
uniform 	float _LightMapIntensity;
uniform 	vec4 _MainColor;
uniform 	mediump float _Reflectivity;
uniform 	float _fresnelBase;
uniform 	float _fresnelScale;
uniform 	float _fresnelIndensity;
uniform 	vec4 _fresnelCol;
uniform 	mediump float _DetailIntensity;
uniform 	mediump float _LumiFactor;
uniform 	float _Transparent;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _DetailTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp samplerCube _EnvTex;
in mediump vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
lowp vec3 u_xlat10_4;
bvec2 u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
mediump vec3 u_xlat16_14;
float u_xlat16;
float u_xlat24;
lowp float u_xlat10_24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD3.xyz;
    u_xlat24 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat1.xyz = vec3(u_xlat24) * vs_TEXCOORD4.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_3 = texture(_ShadowTex, vs_TEXCOORD0.zw);
    u_xlat10_4.xyz = texture(_DetailTex, vs_TEXCOORD1.xy).xyz;
    u_xlatb5.xy = lessThan(ivec4(0, 0, 0, 0), ivec4(_EnableSperateAlpha, _EnableFresnel, _EnableSperateAlpha, _EnableSperateAlpha)).xy;
    if(u_xlatb5.x){
        u_xlat10_24 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
        u_xlat16_6 = u_xlat10_24;
    } else {
        u_xlat16_6 = u_xlat10_2.w;
    //ENDIF
    }
    u_xlat16_14.xyz = u_xlat10_3.xyz + u_xlat10_3.xyz;
    u_xlat16_14.xyz = u_xlat16_14.xyz * u_xlat10_3.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_14.xyz = (-u_xlat10_3.www) + u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat10_2.xyz * u_xlat16_14.xyz;
    u_xlat2.xyz = u_xlat16_14.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat24 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * (-vec3(u_xlat24)) + (-u_xlat1.xyz);
    u_xlat10_3.xyz = texture(_EnvTex, u_xlat3.xyz).xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_6) * u_xlat10_3.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Reflectivity);
    u_xlat2.xyz = u_xlat2.xyz * _MainColor.xyz + u_xlat16_3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _fresnelIndensity;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = _fresnelScale * u_xlat0.x + _fresnelBase;
    u_xlat0.xyz = u_xlat0.xxx * _fresnelCol.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (u_xlatb5.y) ? u_xlat0.xyz : u_xlat2.xyz;
    u_xlat16_14.xyz = u_xlat10_4.xyz * vec3(_DetailIntensity) + u_xlat16_14.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD5.z<_WaterPlaneHeight);
#else
    u_xlatb0 = vs_TEXCOORD5.z<_WaterPlaneHeight;
#endif
    u_xlat8.x = (-vs_TEXCOORD5.z) + _WaterPlaneHeight;
    u_xlat16 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat8.x = u_xlat8.x / u_xlat16;
    u_xlat8.x = max(u_xlat8.x, 0.0);
    u_xlat1.x = u_xlat8.x * _UWFogColorHLIntensity;
    u_xlat16 = (-_UWHeightFogDensity) * u_xlat8.x + 1.0;
    u_xlat16 = u_xlat16 * _UWHeightFogEffectLimit;
    u_xlat16 = max(u_xlat16, _UWHeightFogEffectStart);
    u_xlat16 = min(u_xlat16, _UWHeightFogEffectLimit);
    u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.99000001<vs_TEXCOORD5.y);
#else
    u_xlatb24 = 0.99000001<vs_TEXCOORD5.y;
#endif
    u_xlat8.x = (-u_xlat8.x) * _UWHeightRatio + 1.0;
    u_xlat8.x = u_xlat8.x * vs_TEXCOORD5.y;
    u_xlat8.x = max(u_xlat8.x, _UWCriticalRange);
    u_xlat8.x = min(u_xlat8.x, 1.0);
    u_xlat16_7 = (u_xlatb24) ? u_xlat8.x : vs_TEXCOORD5.y;
    u_xlat16_7 = (-u_xlat16_7) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD5.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat2.xyz = (-u_xlat9.xyz) + u_xlat16_14.xyz;
    u_xlat9.xyz = vec3(u_xlat16_7) * u_xlat2.xyz + u_xlat9.xyz;
    u_xlat2.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat1.xxx * u_xlat2.xyz + _UWFogColorLow.xyz;
    u_xlat1.xyz = u_xlat9.xyz + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat16) * u_xlat1.xyz + u_xlat2.xyz;
    u_xlat16_14.xyz = (bool(u_xlatb0)) ? u_xlat8.xyz : u_xlat16_14.xyz;
    SV_Target0.w = u_xlat16_6 * _Transparent;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0.x = dot(u_xlat16_14.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_14.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_14.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
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
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 66802
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
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
in highp vec4 in_POSITION0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
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
in highp vec4 in_POSITION0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
layout(location = 0) out mediump vec4 SV_Target0;
void main()
{
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
}