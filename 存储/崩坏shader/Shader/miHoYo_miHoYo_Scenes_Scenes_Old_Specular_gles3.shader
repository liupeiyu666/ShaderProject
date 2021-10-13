//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Specular" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
[Toggle] _UseMainTexAlphaAsMask ("Use Main Tex Alpha as Mask", Float) = 0
_ShadowTex ("LightMap (RGB)", 2D) = "white" { }
_LightMapIntensity ("Light Map Intensity", Float) = 1
_LightMapThreshold ("Light Map Threshold", Range(0, 1)) = 0.5
[Toggle] _UseMiHoYoLightDir ("Use Env Light Dir", Float) = 1
_LightDir ("Light Dir", Vector) = (0,-1,0,0)
_Shininess ("Shininess", Range(0, 100)) = 10
_SpeculaColor ("Specular Color", Color) = (1,1,1,1)
_SpecularIntensity ("Specular Intensity", Range(0, 10)) = 1
[Toggle] _UseNormalMap ("Use Normal Map", Float) = 0
_NormalMap ("Normal Map", 2D) = "green" { }
_NormalMapScaleX ("Normal Map Scale X", Range(0, 1)) = 1
_NormalMapScaleY ("Normal Map Scale Y", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 LOD 200
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 54418
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogParams.x;
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
    u_xlat12 = u_xlat4.x * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat4.x * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat4.yzx + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_3.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat4.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat4.x;
    vs_TEXCOORD7.x = u_xlat4.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_3.y;
    vs_TEXCOORD7.y = u_xlat16_3.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogParams.x;
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
    u_xlat12 = u_xlat4.x * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat4.x * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat4.yzx + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_3.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat4.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat4.x;
    vs_TEXCOORD7.x = u_xlat4.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_3.y;
    vs_TEXCOORD7.y = u_xlat16_3.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogParams.x;
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
    u_xlat12 = u_xlat4.x * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat4.x * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat4.yzx + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_3.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat4.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat4.x;
    vs_TEXCOORD7.x = u_xlat4.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_3.y;
    vs_TEXCOORD7.y = u_xlat16_3.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
    u_xlat16_4.x = (-u_xlat5.x) + 2.0;
    u_xlat16_4.x = u_xlat5.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_4.x = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat10 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_4.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat5.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat5.x;
    vs_TEXCOORD7.x = u_xlat5.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
    u_xlat16_4.x = (-u_xlat5.x) + 2.0;
    u_xlat16_4.x = u_xlat5.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_4.x = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat10 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_4.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat5.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat5.x;
    vs_TEXCOORD7.x = u_xlat5.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
    u_xlat16_4.x = (-u_xlat5.x) + 2.0;
    u_xlat16_4.x = u_xlat5.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_4.x = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat10 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_4.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat5.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat5.x;
    vs_TEXCOORD7.x = u_xlat5.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat9;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb21 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat3.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
    u_xlat23 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat3.xyz = vec3(u_xlat23) * u_xlat3.xyz;
    u_xlat23 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_4.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat16_4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = vec3(u_xlat23) * u_xlat16_4.xyz;
    vs_TEXCOORD5.x = (u_xlatb21) ? u_xlat3.z : u_xlat2.y;
    vs_TEXCOORD5.y = (u_xlatb21) ? u_xlat16_4.x : u_xlat2.z;
    vs_TEXCOORD5.z = (u_xlatb21) ? u_xlat2.y : u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb21 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb21){
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * (-u_xlat9.xz);
        u_xlat9.xz = u_xlat9.xz * vec2(1.44269502, 1.44269502);
        u_xlat9.xz = exp2(u_xlat9.xz);
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat21 = u_xlat21 * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = u_xlat9.zzz * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    } else {
        u_xlat5.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
        u_xlat21 = sqrt(u_xlat21);
        u_xlat21 = u_xlat21 + (-_FogStartDistance);
        u_xlat21 = max(u_xlat21, 0.0);
        u_xlat9.xz = vec2(u_xlat21) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat9.xz = u_xlat9.xz * vec2(500.0, 1000.0);
        u_xlat21 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat21 = max(u_xlat21, 0.100000001);
        u_xlat9.xz = u_xlat9.zx / vec2(u_xlat21);
        u_xlat21 = u_xlat9.z * _FogEffectLimit;
        u_xlat21 = max(u_xlat21, _FogEffectStart);
        u_xlat5.w = min(u_xlat21, _FogEffectLimit);
        u_xlat9.x = u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
        u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
        u_xlat21 = (-u_xlat9.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat5.xyz = vec3(u_xlat21) * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat5;
    //ENDIF
    }
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD6.x = u_xlat3.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD6.z = u_xlat2.z;
    vs_TEXCOORD7.x = u_xlat3.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
    vs_TEXCOORD7.z = u_xlat2.x;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogParams.x;
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
    u_xlat12 = u_xlat4.x * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat4.x * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat4.yzx + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_3.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat4.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat4.x;
    vs_TEXCOORD7.x = u_xlat4.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_3.y;
    vs_TEXCOORD7.y = u_xlat16_3.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogParams.x;
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
    u_xlat12 = u_xlat4.x * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat4.x * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat4.yzx + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_3.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat4.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat4.x;
    vs_TEXCOORD7.x = u_xlat4.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_3.y;
    vs_TEXCOORD7.y = u_xlat16_3.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    u_xlat12 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat12) + 2.0;
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogParams.x;
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
    u_xlat12 = u_xlat4.x * -1.44269502;
    u_xlat8.y = exp2(u_xlat12);
    u_xlat8.xy = (-u_xlat8.xy) + vec2(1.0, 1.0);
    u_xlat12 = u_xlat8.y / u_xlat4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.00999999978<abs(u_xlat4.x));
#else
    u_xlatb4 = 0.00999999978<abs(u_xlat4.x);
#endif
    u_xlat16_3.x = (u_xlatb4) ? u_xlat12 : 1.0;
    u_xlat4.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat4.x * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColBase.w);
    u_xlat4.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat4.x * u_xlat8.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat4.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat4.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat4.xyz = u_xlat4.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat4.xyz * u_xlat1.xyz;
    u_xlat16_3.xyz = u_xlat1.zxy * u_xlat4.yzx + (-u_xlat16_3.xyz);
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_3.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat4.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat4.x;
    vs_TEXCOORD7.x = u_xlat4.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_3.y;
    vs_TEXCOORD7.y = u_xlat16_3.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
    u_xlat16_4.x = (-u_xlat5.x) + 2.0;
    u_xlat16_4.x = u_xlat5.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_4.x = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat10 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_4.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat5.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat5.x;
    vs_TEXCOORD7.x = u_xlat5.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
    u_xlat16_4.x = (-u_xlat5.x) + 2.0;
    u_xlat16_4.x = u_xlat5.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_4.x = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat10 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_4.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat5.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat5.x;
    vs_TEXCOORD7.x = u_xlat5.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	mediump float _UseNormalMap;
uniform 	vec4 _NormalMap_ST;
in highp vec4 in_POSITION0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
out mediump vec3 vs_TEXCOORD7;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD0.xy * _NormalMap_ST.xy + _NormalMap_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
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
    u_xlat16_4.x = (-u_xlat5.x) + 2.0;
    u_xlat16_4.x = u_xlat5.x * u_xlat16_4.x;
    u_xlat1.xyz = u_xlat16_4.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
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
    u_xlat16_4.x = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat10 * u_xlat16_4.x;
    u_xlat16_4.x = exp2((-u_xlat16_4.x));
    u_xlat16_4.x = min(u_xlat16_4.x, 1.0);
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4.x = u_xlat0.x * u_xlat16_4.x;
    u_xlat0.x = min(u_xlat16_4.x, _HeigtFogColBase2.w);
    u_xlat10 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat2.w = u_xlat10 * u_xlat5.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = (-u_xlat2) + u_xlat3;
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    vs_COLOR1 = u_xlat0;
    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat5.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat5.xyz;
    u_xlat1.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat5.xyz = u_xlat5.xyz * u_xlat1.xxx;
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat5.xyz * u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat1.zxy * u_xlat5.yzx + (-u_xlat16_4.xyz);
    u_xlat16_4.xyz = u_xlat0.xxx * u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    vs_TEXCOORD5.y = (u_xlatb0) ? u_xlat16_4.x : u_xlat1.z;
    vs_TEXCOORD5.x = (u_xlatb0) ? u_xlat5.z : u_xlat1.y;
    vs_TEXCOORD5.z = (u_xlatb0) ? u_xlat1.y : u_xlat1.x;
    vs_TEXCOORD6.x = u_xlat5.x;
    vs_TEXCOORD7.x = u_xlat5.y;
    vs_TEXCOORD6.z = u_xlat1.z;
    vs_TEXCOORD7.z = u_xlat1.x;
    vs_TEXCOORD6.y = u_xlat16_4.y;
    vs_TEXCOORD7.y = u_xlat16_4.z;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD2 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _Color;
uniform 	mediump float _UseMainTexAlphaAsMask;
uniform 	float _LightMapIntensity;
uniform 	mediump float _LightMapThreshold;
uniform 	mediump float _UseMiHoYoLightDir;
uniform 	mediump vec3 _miHoYo_LightDir;
uniform 	mediump vec3 _LightDir;
uniform 	mediump float _Shininess;
uniform 	mediump vec3 _SpeculaColor;
uniform 	mediump float _SpecularIntensity;
uniform 	mediump float _UseNormalMap;
uniform 	float _BloomFactor;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _NormalMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
in mediump vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat16;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_ShadowTex, vs_TEXCOORD3.xy).xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseNormalMap);
#endif
    if(u_xlatb0){
        u_xlat10_0.xyz = texture(_NormalMap, vs_TEXCOORD2.xy).xyz;
        u_xlat16_3.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
        u_xlat16_4.x = dot(vs_TEXCOORD5.xyz, u_xlat16_3.xyz);
        u_xlat16_4.y = dot(vs_TEXCOORD6.xyz, u_xlat16_3.xyz);
        u_xlat16_4.z = dot(vs_TEXCOORD7.xyz, u_xlat16_3.xyz);
    } else {
        u_xlat16_4.xyz = vs_TEXCOORD5.xyz;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMiHoYoLightDir);
#endif
    u_xlat16_3.xyz = (bool(u_xlatb0)) ? _miHoYo_LightDir.xyz : _LightDir.xyz;
    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat16 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat16_3.xyz = u_xlat0.xyz * vec3(u_xlat16) + (-u_xlat16_3.xyz);
    u_xlat16_17 = dot(u_xlat16_3.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = inversesqrt(u_xlat16_17);
    u_xlat16_3.xyz = vec3(u_xlat16_17) * u_xlat16_3.xyz;
    u_xlat16_17 = dot(u_xlat16_4.xyz, u_xlat16_3.xyz);
    u_xlat16_17 = max(u_xlat16_17, 0.00100000005);
    u_xlat16_17 = log2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _Shininess;
    u_xlat16_17 = exp2(u_xlat16_17);
    u_xlat16_17 = u_xlat16_17 * _SpecularIntensity;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask));
#else
    u_xlatb0 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseMainTexAlphaAsMask);
#endif
    u_xlat16_3.x = u_xlat10_0.w * u_xlat16_17;
    u_xlat16_17 = (u_xlatb0) ? u_xlat16_3.x : u_xlat16_17;
    u_xlat16_3.x = dot(u_xlat10_1.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_3.x = u_xlat16_3.x + (-_LightMapThreshold);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = ceil(u_xlat16_3.x);
    u_xlat16_17 = u_xlat16_17 * u_xlat16_3.x;
    u_xlat16_3.xyz = vec3(u_xlat16_17) * _SpeculaColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    u_xlat0.w = _BloomFactor;
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
}
}