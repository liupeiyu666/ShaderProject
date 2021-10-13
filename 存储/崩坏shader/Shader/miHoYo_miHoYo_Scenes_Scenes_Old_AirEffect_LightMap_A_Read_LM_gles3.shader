//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_A_Read_LM" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(DEBUG_LIGHTMAP)] _DebugLightmap ("DebugLightmap", Float) = 0
_RGLightMap ("Rim Glow Ratio", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 16065
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat2;
    //ENDIF
    }
    vs_COLOR1 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat2;
    //ENDIF
    }
    vs_COLOR1 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat2;
    //ENDIF
    }
    vs_COLOR1 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat2;
    //ENDIF
    }
    vs_COLOR1 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat2;
    //ENDIF
    }
    vs_COLOR1 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat6;
float u_xlat7;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat1;
    } else {
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat1.x = sqrt(u_xlat1.x);
        u_xlat1.x = u_xlat1.x + (-_FogStartDistance);
        u_xlat1.x = max(u_xlat1.x, 0.0);
        u_xlat1.xy = u_xlat1.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * vec2(500.0, 1000.0);
        u_xlat7 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat7 = max(u_xlat7, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat7);
        u_xlat4.x = u_xlat1.y * _FogEffectLimit;
        u_xlat7 = _FogEffectStart * _FogTune;
        u_xlat4.x = max(u_xlat7, u_xlat4.x);
        u_xlat2.w = min(u_xlat4.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat4.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat4.xyz + _FogColorFar.xyz;
        u_xlat16_0 = u_xlat2;
    //ENDIF
    }
    vs_COLOR1 = u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    vs_COLOR1.w = u_xlat4 * u_xlat8.x;
    vs_COLOR1.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    vs_COLOR1.w = u_xlat4 * u_xlat8.x;
    vs_COLOR1.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    vs_COLOR1.w = u_xlat4 * u_xlat8.x;
    vs_COLOR1.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    vs_COLOR1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    vs_COLOR1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
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
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    vs_COLOR1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _RGLightMap;
uniform 	mediump float _DebugLightmap;
uniform highp sampler2D _MainTex;
uniform highp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_COLOR1;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb15;
void main()
{
    u_xlat0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat1.x = (-u_xlat0.w) + 1.0;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xxx;
    u_xlat2.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat3.xyz = u_xlat0.xyz * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.www + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(0.0<_DebugLightmap);
#else
    u_xlatb15 = 0.0<_DebugLightmap;
#endif
    u_xlat16_4 = (-_RGLightMap) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat16_4);
    u_xlat0.xyz = u_xlat2.xyz * vec3(_RGLightMap) + u_xlat0.xyz;
    u_xlat0.xyz = (bool(u_xlatb15)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat0.xyz + u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_COLOR1 = u_xlat16_1;
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_COLOR1 = u_xlat16_1;
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_COLOR1 = u_xlat16_1;
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_COLOR1 = u_xlat16_1;
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_COLOR1 = u_xlat16_1;
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat6;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
        u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
        u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat12 = u_xlat1.x * _FogTune;
        u_xlat12 = u_xlat12 * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat12 = (-u_xlat12) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat1.x = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat1.x);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat12 = u_xlat1.y * 1.44269502;
        u_xlat12 = exp2(u_xlat12);
        u_xlat1.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = vec3(u_xlat12) * u_xlat1.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat2.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat2.xy = u_xlat2.xy * vec2(500.0, 1000.0);
        u_xlat12 = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.100000001);
        u_xlat2.xy = u_xlat2.yx / vec2(u_xlat12);
        u_xlat12 = u_xlat2.y * _FogEffectLimit;
        u_xlat6 = _FogEffectStart * _FogTune;
        u_xlat12 = max(u_xlat12, u_xlat6);
        u_xlat3.w = min(u_xlat12, _FogEffectLimit);
        u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
        u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
        u_xlat12 = (-u_xlat2.x) + 1.0;
        u_xlat2.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat3.xyz = vec3(u_xlat12) * u_xlat2.xyz + _FogColorFar.xyz;
        u_xlat16_1 = u_xlat3;
    //ENDIF
    }
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2.xy = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = u_xlat2.x + (-_UWFogDistStart);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.xy = u_xlat2.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat2.xy = u_xlat2.xy * (-u_xlat2.xy);
    u_xlat2.xy = u_xlat2.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat2.xy);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_COLOR1 = u_xlat16_1;
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_8;
vec2 u_xlat12;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat17 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat16>=u_xlat2.x;
#endif
    u_xlat7 = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat7) + 2.0;
    u_xlat7 = u_xlat12.x * u_xlat7;
    u_xlat12.x = u_xlat7 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat12.x : u_xlat7;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat7 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat12.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat12.x = sqrt(u_xlat12.x);
    u_xlat12.x = u_xlat12.x + (-_UWFogDistStart);
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat12.xy = u_xlat12.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat12.xy);
    u_xlat12.x = u_xlat7 * -1.44269502;
    u_xlat2.z = exp2(u_xlat12.x);
    u_xlat2.xz = (-u_xlat2.xz) + vec2(1.0, 1.0);
    u_xlat12.x = u_xlat2.z / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_3 = (u_xlatb7) ? u_xlat12.x : 1.0;
    u_xlat7 = u_xlat16 * _HeigtFogParams.y;
    u_xlat16 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat7 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat7 = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat7);
    vs_COLOR1.w = u_xlat7 * u_xlat2.x;
    vs_COLOR1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_8;
vec2 u_xlat12;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat17 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat16>=u_xlat2.x;
#endif
    u_xlat7 = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat7) + 2.0;
    u_xlat7 = u_xlat12.x * u_xlat7;
    u_xlat12.x = u_xlat7 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat12.x : u_xlat7;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat7 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat12.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat12.x = sqrt(u_xlat12.x);
    u_xlat12.x = u_xlat12.x + (-_UWFogDistStart);
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat12.xy = u_xlat12.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat12.xy);
    u_xlat12.x = u_xlat7 * -1.44269502;
    u_xlat2.z = exp2(u_xlat12.x);
    u_xlat2.xz = (-u_xlat2.xz) + vec2(1.0, 1.0);
    u_xlat12.x = u_xlat2.z / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_3 = (u_xlatb7) ? u_xlat12.x : 1.0;
    u_xlat7 = u_xlat16 * _HeigtFogParams.y;
    u_xlat16 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat7 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat7 = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat7);
    vs_COLOR1.w = u_xlat7 * u_xlat2.x;
    vs_COLOR1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_8;
vec2 u_xlat12;
float u_xlat16;
float u_xlat17;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat16 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat16 = sqrt(u_xlat16);
    u_xlat17 = u_xlat16 + (-_HeigtFogRamp.w);
    u_xlat17 = u_xlat17 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat17 = min(max(u_xlat17, 0.0), 1.0);
#else
    u_xlat17 = clamp(u_xlat17, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat17) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat16>=u_xlat2.x);
#else
    u_xlatb2 = u_xlat16>=u_xlat2.x;
#endif
    u_xlat7 = u_xlat16 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat12.x = (-u_xlat7) + 2.0;
    u_xlat7 = u_xlat12.x * u_xlat7;
    u_xlat12.x = u_xlat7 * _HeigtFogColDelta.w;
    u_xlat2.x = (u_xlatb2) ? u_xlat12.x : u_xlat7;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat7 = u_xlat4.y * _HeigtFogParams.x;
    u_xlat12.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat12.x = sqrt(u_xlat12.x);
    u_xlat12.x = u_xlat12.x + (-_UWFogDistStart);
    u_xlat12.x = max(u_xlat12.x, 0.0);
    u_xlat12.xy = u_xlat12.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat12.xy = u_xlat12.xy * (-u_xlat12.xy);
    u_xlat12.xy = u_xlat12.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat12.xy);
    u_xlat12.x = u_xlat7 * -1.44269502;
    u_xlat2.z = exp2(u_xlat12.x);
    u_xlat2.xz = (-u_xlat2.xz) + vec2(1.0, 1.0);
    u_xlat12.x = u_xlat2.z / u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.00999999978<abs(u_xlat7));
#else
    u_xlatb7 = 0.00999999978<abs(u_xlat7);
#endif
    u_xlat16_3 = (u_xlatb7) ? u_xlat12.x : 1.0;
    u_xlat7 = u_xlat16 * _HeigtFogParams.y;
    u_xlat16 = u_xlat16 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat7 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_8 = (-u_xlat16) + 2.0;
    u_xlat16_8 = u_xlat16 * u_xlat16_8;
    u_xlat16 = u_xlat16_8 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_3 = u_xlat16 * u_xlat16_3;
    u_xlat16 = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat7 = (-u_xlat16) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat7);
    vs_COLOR1.w = u_xlat7 * u_xlat2.x;
    vs_COLOR1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat16) + u_xlat1.xyz;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat19;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat20 = u_xlat19 + (-_HeigtFogRamp3.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat19 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8 * u_xlat2.x;
    u_xlat8 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat19>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat19>=u_xlat14.x;
#endif
    u_xlat2.x = (u_xlatb14) ? u_xlat8 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat20 = u_xlat8 * -1.44269502;
    u_xlat2.w = exp2(u_xlat20);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat20 = u_xlat2.w / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat20 : 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat8) + 2.0;
    u_xlat16_9 = u_xlat8 * u_xlat16_9;
    u_xlat8 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat8 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat20 = (-u_xlat8) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat20);
    u_xlat3.w = u_xlat20 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat19 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyw + u_xlat1.xyz;
    u_xlat2.x = u_xlat19 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8 * u_xlat2.x;
    u_xlat8 = u_xlat2.x * _HeigtFogColDelta2.w;
    u_xlat2.x = (u_xlatb14) ? u_xlat8 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor2.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat14.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat14.x = sqrt(u_xlat14.x);
    u_xlat14.x = u_xlat14.x + (-_UWFogDistStart);
    u_xlat14.x = max(u_xlat14.x, 0.0);
    u_xlat14.xy = u_xlat14.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat14.xy = u_xlat14.xy * (-u_xlat14.xy);
    u_xlat14.xy = u_xlat14.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat14.xy);
    u_xlat14.x = u_xlat8 * -1.44269502;
    u_xlat2.z = exp2(u_xlat14.x);
    u_xlat2.xz = (-u_xlat2.xz) + vec2(1.0, 1.0);
    u_xlat14.x = u_xlat2.z / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_5 = (u_xlatb8) ? u_xlat14.x : 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogParams2.y;
    u_xlat19 = u_xlat19 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat8 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat19) + 2.0;
    u_xlat16_11 = u_xlat19 * u_xlat16_11;
    u_xlat19 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_5 = u_xlat19 * u_xlat16_5;
    u_xlat19 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat8 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    vs_COLOR1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat19;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat20 = u_xlat19 + (-_HeigtFogRamp3.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat19 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8 * u_xlat2.x;
    u_xlat8 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat19>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat19>=u_xlat14.x;
#endif
    u_xlat2.x = (u_xlatb14) ? u_xlat8 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat20 = u_xlat8 * -1.44269502;
    u_xlat2.w = exp2(u_xlat20);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat20 = u_xlat2.w / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat20 : 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat8) + 2.0;
    u_xlat16_9 = u_xlat8 * u_xlat16_9;
    u_xlat8 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat8 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat20 = (-u_xlat8) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat20);
    u_xlat3.w = u_xlat20 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat19 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyw + u_xlat1.xyz;
    u_xlat2.x = u_xlat19 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8 * u_xlat2.x;
    u_xlat8 = u_xlat2.x * _HeigtFogColDelta2.w;
    u_xlat2.x = (u_xlatb14) ? u_xlat8 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor2.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat14.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat14.x = sqrt(u_xlat14.x);
    u_xlat14.x = u_xlat14.x + (-_UWFogDistStart);
    u_xlat14.x = max(u_xlat14.x, 0.0);
    u_xlat14.xy = u_xlat14.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat14.xy = u_xlat14.xy * (-u_xlat14.xy);
    u_xlat14.xy = u_xlat14.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat14.xy);
    u_xlat14.x = u_xlat8 * -1.44269502;
    u_xlat2.z = exp2(u_xlat14.x);
    u_xlat2.xz = (-u_xlat2.xz) + vec2(1.0, 1.0);
    u_xlat14.x = u_xlat2.z / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_5 = (u_xlatb8) ? u_xlat14.x : 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogParams2.y;
    u_xlat19 = u_xlat19 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat8 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat19) + 2.0;
    u_xlat16_11 = u_xlat19 * u_xlat16_11;
    u_xlat19 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_5 = u_xlat19 * u_xlat16_5;
    u_xlat19 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat8 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    vs_COLOR1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
    SV_Target0.w = _BloomFactor;
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
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
vec2 u_xlat14;
bool u_xlatb14;
float u_xlat19;
float u_xlat20;
float u_xlat22;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_3 = (-u_xlat1.x) + 2.0;
    u_xlat16_3 = u_xlat1.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat4.xyz = u_xlat0.xwy + (-_WorldSpaceCameraPos.xyz);
    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat20 = u_xlat19 + (-_HeigtFogRamp3.w);
    u_xlat20 = u_xlat20 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat20 = min(max(u_xlat20, 0.0), 1.0);
#else
    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat20) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.x = u_xlat19 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8 * u_xlat2.x;
    u_xlat8 = u_xlat2.x * _HeigtFogColDelta3.w;
    u_xlat14.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(u_xlat19>=u_xlat14.x);
#else
    u_xlatb14 = u_xlat19>=u_xlat14.x;
#endif
    u_xlat2.x = (u_xlatb14) ? u_xlat8 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor3.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase3.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat4.y * _HeigtFogParams3.x;
    u_xlat20 = u_xlat8 * -1.44269502;
    u_xlat2.w = exp2(u_xlat20);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat20 = u_xlat2.w / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat20 : 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogParams3.y;
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat8 = min(max(u_xlat8, 0.0), 1.0);
#else
    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat8) + 2.0;
    u_xlat16_9 = u_xlat8 * u_xlat16_9;
    u_xlat8 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat8 = u_xlat8 + 1.0;
    u_xlat16_3 = u_xlat8 * u_xlat16_3;
    u_xlat8 = min(u_xlat16_3, _HeigtFogColBase3.w);
    u_xlat20 = (-u_xlat8) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat20);
    u_xlat3.w = u_xlat20 * u_xlat2.x;
    u_xlat3.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat8) + u_xlat1.xyz;
    u_xlat1.x = u_xlat0.w * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat1.x) + 2.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat2.xyw = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat22 = u_xlat19 + (-_HeigtFogRamp2.w);
    u_xlat22 = u_xlat22 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat2.xyw + u_xlat1.xyz;
    u_xlat2.x = u_xlat19 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat8 = (-u_xlat2.x) + 2.0;
    u_xlat2.x = u_xlat8 * u_xlat2.x;
    u_xlat8 = u_xlat2.x * _HeigtFogColDelta2.w;
    u_xlat2.x = (u_xlatb14) ? u_xlat8 : u_xlat2.x;
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Mihoyo_FogColor2.w;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, _HeigtFogColBase2.w);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat8 = u_xlat4.y * _HeigtFogParams2.x;
    u_xlat14.x = dot(u_xlat4.xz, u_xlat4.xz);
    u_xlat14.x = sqrt(u_xlat14.x);
    u_xlat14.x = u_xlat14.x + (-_UWFogDistStart);
    u_xlat14.x = max(u_xlat14.x, 0.0);
    u_xlat14.xy = u_xlat14.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat14.xy = u_xlat14.xy * (-u_xlat14.xy);
    u_xlat14.xy = u_xlat14.xy * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat14.xy);
    u_xlat14.x = u_xlat8 * -1.44269502;
    u_xlat2.z = exp2(u_xlat14.x);
    u_xlat2.xz = (-u_xlat2.xz) + vec2(1.0, 1.0);
    u_xlat14.x = u_xlat2.z / u_xlat8;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8);
#endif
    u_xlat16_5 = (u_xlatb8) ? u_xlat14.x : 1.0;
    u_xlat8 = u_xlat19 * _HeigtFogParams2.y;
    u_xlat19 = u_xlat19 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat8 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat19) + 2.0;
    u_xlat16_11 = u_xlat19 * u_xlat16_11;
    u_xlat19 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_5 = u_xlat19 * u_xlat16_5;
    u_xlat19 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat8 = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat8);
    u_xlat2.w = u_xlat8 * u_xlat2.x;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat1 = (-u_xlat2) + u_xlat3;
    vs_COLOR1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    vs_TEXCOORD2.xyz = u_xlat0.yzw;
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
uniform 	mediump float _BloomFactor;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat5;
bool u_xlatb6;
bool u_xlatb9;
void main()
{
    u_xlat0.x = (-vs_TEXCOORD2.z) + _WaterPlaneHeight;
    u_xlat3.x = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat0.x = u_xlat0.x / u_xlat3.x;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat3.x = (-u_xlat0.x) * _UWHeightRatio + 1.0;
    u_xlat3.x = u_xlat3.x * vs_TEXCOORD2.y;
    u_xlat3.x = max(u_xlat3.x, _UWCriticalRange);
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.99000001<vs_TEXCOORD2.y);
#else
    u_xlatb6 = 0.99000001<vs_TEXCOORD2.y;
#endif
    u_xlat16_1 = (u_xlatb6) ? u_xlat3.x : vs_TEXCOORD2.y;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat3.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat3.xyz = vs_TEXCOORD2.xxx * u_xlat3.xyz + _UWFogColorFar.xyz;
    u_xlat3.xyz = vec3(u_xlat16_1) * (-u_xlat3.xyz) + u_xlat3.xyz;
    u_xlat2.x = u_xlat0.x * _UWFogColorHLIntensity;
    u_xlat0.x = (-_UWHeightFogDensity) * u_xlat0.x + 1.0;
    u_xlat0.x = u_xlat0.x * _UWHeightFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWHeightFogEffectStart);
    u_xlat0.x = min(u_xlat0.x, _UWHeightFogEffectLimit);
    u_xlat2.x = u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat2.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat2.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(vs_TEXCOORD2.z<_WaterPlaneHeight);
#else
    u_xlatb9 = vs_TEXCOORD2.z<_WaterPlaneHeight;
#endif
    SV_Target0.xyz = mix(vec3(0.0, 0.0, 0.0), u_xlat0.xyz, vec3(bvec3(u_xlatb9)));
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
}
}
}
Fallback "Diffuse"
}