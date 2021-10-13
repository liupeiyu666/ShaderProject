//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/AirEffect_LightMap_Flag_Transparent" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_ObjectHeight ("Object Height", Float) = 1
_ObjectMoveScale ("Object MoveScale", Range(0, 1)) = 0.4
_ObjectPivot ("Object MoveScale", Vector) = (0,0,0,0)
_Frequency ("Frequency", Float) = 1
_AmplitudeStrength ("Amplitude Strength", Float) = 1
_InvWaveLength ("Inverse Wave Length", Float) = 1
_Fold ("Fold", Range(0, 2)) = 0.5
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 31589
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat4.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat4.x = u_xlat4.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat4.x = u_xlat4.x + _miHoYo_WindParams3.x;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _ObjectMoveScale;
    u_xlat8.x = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat8.xy = u_xlat8.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat4.x * u_xlat1.y + u_xlat8.x;
    u_xlat2.y = (-u_xlat4.x) * u_xlat1.x + u_xlat8.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat4.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat4.z;
    u_xlat1 = u_xlat4.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat4.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8.x = u_xlat0.z * _HeigtFogParams.x;
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
    u_xlat16_3 = (-u_xlat4.x) + 2.0;
    u_xlat16_3 = u_xlat4.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4.x = u_xlat4.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4.x = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8.x);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat8.x * u_xlat4.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat4.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat4.x = u_xlat4.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat4.x = u_xlat4.x + _miHoYo_WindParams3.x;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _ObjectMoveScale;
    u_xlat8.x = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat8.xy = u_xlat8.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat4.x * u_xlat1.y + u_xlat8.x;
    u_xlat2.y = (-u_xlat4.x) * u_xlat1.x + u_xlat8.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat4.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat4.z;
    u_xlat1 = u_xlat4.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat4.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8.x = u_xlat0.z * _HeigtFogParams.x;
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
    u_xlat16_3 = (-u_xlat4.x) + 2.0;
    u_xlat16_3 = u_xlat4.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4.x = u_xlat4.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4.x = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8.x);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat8.x * u_xlat4.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat4.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat4.x = u_xlat4.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat4.x = u_xlat4.x + _miHoYo_WindParams3.x;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _ObjectMoveScale;
    u_xlat8.x = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat8.xy = u_xlat8.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat4.x * u_xlat1.y + u_xlat8.x;
    u_xlat2.y = (-u_xlat4.x) * u_xlat1.x + u_xlat8.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat4.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat4.z;
    u_xlat1 = u_xlat4.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat4.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8.x = u_xlat0.z * _HeigtFogParams.x;
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
    u_xlat16_3 = (-u_xlat4.x) + 2.0;
    u_xlat16_3 = u_xlat4.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4.x = u_xlat4.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4.x = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8.x);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat8.x * u_xlat4.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat5.x = u_xlat5.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat5.x = u_xlat5.x + _miHoYo_WindParams3.x;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _ObjectMoveScale;
    u_xlat10.x = (-u_xlat5.x) * u_xlat5.x + 1.0;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat5.x * u_xlat1.y + u_xlat10.x;
    u_xlat2.y = (-u_xlat5.x) * u_xlat1.x + u_xlat10.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat5.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat5.z;
    u_xlat1 = u_xlat5.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    u_xlat10.x = u_xlat0.z * _HeigtFogParams2.x;
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
    u_xlat15 = u_xlat10.x * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat10.x * u_xlat5.x;
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
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat5.x = u_xlat5.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat5.x = u_xlat5.x + _miHoYo_WindParams3.x;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _ObjectMoveScale;
    u_xlat10.x = (-u_xlat5.x) * u_xlat5.x + 1.0;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat5.x * u_xlat1.y + u_xlat10.x;
    u_xlat2.y = (-u_xlat5.x) * u_xlat1.x + u_xlat10.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat5.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat5.z;
    u_xlat1 = u_xlat5.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    u_xlat10.x = u_xlat0.z * _HeigtFogParams2.x;
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
    u_xlat15 = u_xlat10.x * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat10.x * u_xlat5.x;
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
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat5.x = u_xlat5.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat5.x = u_xlat5.x + _miHoYo_WindParams3.x;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _ObjectMoveScale;
    u_xlat10.x = (-u_xlat5.x) * u_xlat5.x + 1.0;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat5.x * u_xlat1.y + u_xlat10.x;
    u_xlat2.y = (-u_xlat5.x) * u_xlat1.x + u_xlat10.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat5.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat5.z;
    u_xlat1 = u_xlat5.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    u_xlat10.x = u_xlat0.z * _HeigtFogParams2.x;
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
    u_xlat15 = u_xlat10.x * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat10.x * u_xlat5.x;
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
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
uniform 	mediump float _FogTune;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat6;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat6.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat6.x;
    u_xlat3.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat3.x = u_xlat3.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat3.x = u_xlat3.x + _miHoYo_WindParams3.x;
    u_xlat3.x = sin(u_xlat3.x);
    u_xlat3.x = u_xlat3.x * _ObjectMoveScale;
    u_xlat6.x = (-u_xlat3.x) * u_xlat3.x + 1.0;
    u_xlat6.x = sqrt(u_xlat6.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat6.xy = u_xlat6.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat3.x * u_xlat1.y + u_xlat6.x;
    u_xlat2.y = (-u_xlat3.x) * u_xlat1.x + u_xlat6.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat3.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat3.z;
    u_xlat1 = u_xlat3.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat3.yyyy + u_xlat1;
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
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat0.x = max(u_xlat6.x, u_xlat0.x);
        u_xlat1.w = min(u_xlat0.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.y * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
        u_xlat6.x = _FogEndDistance * _FogTune + (-_FogStartDistance);
        u_xlat6.x = max(u_xlat6.x, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / u_xlat6.xx;
        u_xlat3.x = u_xlat0.y * _FogEffectLimit;
        u_xlat6.x = _FogEffectStart * _FogTune;
        u_xlat3.x = max(u_xlat6.x, u_xlat3.x);
        u_xlat1.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat0.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
        u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + _FogColorFar.xyz;
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
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.xyz = (-u_xlat16_1.xyz) * vec3(_LightMapIntensity) + vs_COLOR1.xyz;
    u_xlat16_1.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat0.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat4.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat4.x = u_xlat4.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat4.x = u_xlat4.x + _miHoYo_WindParams3.x;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _ObjectMoveScale;
    u_xlat8.x = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat8.xy = u_xlat8.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat4.x * u_xlat1.y + u_xlat8.x;
    u_xlat2.y = (-u_xlat4.x) * u_xlat1.x + u_xlat8.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat4.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat4.z;
    u_xlat1 = u_xlat4.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat4.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8.x = u_xlat0.z * _HeigtFogParams.x;
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
    u_xlat16_3 = (-u_xlat4.x) + 2.0;
    u_xlat16_3 = u_xlat4.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4.x = u_xlat4.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4.x = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8.x);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat8.x * u_xlat4.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat4.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat4.x = u_xlat4.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat4.x = u_xlat4.x + _miHoYo_WindParams3.x;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _ObjectMoveScale;
    u_xlat8.x = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat8.xy = u_xlat8.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat4.x * u_xlat1.y + u_xlat8.x;
    u_xlat2.y = (-u_xlat4.x) * u_xlat1.x + u_xlat8.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat4.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat4.z;
    u_xlat1 = u_xlat4.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat4.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8.x = u_xlat0.z * _HeigtFogParams.x;
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
    u_xlat16_3 = (-u_xlat4.x) + 2.0;
    u_xlat16_3 = u_xlat4.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4.x = u_xlat4.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4.x = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8.x);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat8.x * u_xlat4.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_7;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat4.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat4.x = u_xlat4.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat4.x = u_xlat4.x + _miHoYo_WindParams3.x;
    u_xlat4.x = sin(u_xlat4.x);
    u_xlat4.x = u_xlat4.x * _ObjectMoveScale;
    u_xlat8.x = (-u_xlat4.x) * u_xlat4.x + 1.0;
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat8.xy = u_xlat8.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat4.x * u_xlat1.y + u_xlat8.x;
    u_xlat2.y = (-u_xlat4.x) * u_xlat1.x + u_xlat8.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat4.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat4.z;
    u_xlat1 = u_xlat4.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat4.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat4.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat8.x = u_xlat0.z * _HeigtFogParams.x;
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
    u_xlat16_3 = (-u_xlat4.x) + 2.0;
    u_xlat16_3 = u_xlat4.x * u_xlat16_3;
    u_xlat1.xyz = vec3(u_xlat16_3) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat2.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat4.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat4.x = u_xlat4.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat4.xxx * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat4.x = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat8.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.00999999978<abs(u_xlat8.x));
#else
    u_xlatb8 = 0.00999999978<abs(u_xlat8.x);
#endif
    u_xlat16_3 = (u_xlatb8) ? u_xlat12 : 1.0;
    u_xlat8.x = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat8.x * u_xlat16_3;
    u_xlat16_3 = exp2((-u_xlat16_3));
    u_xlat16_3 = min(u_xlat16_3, 1.0);
    u_xlat16_3 = (-u_xlat16_3) + 1.0;
    u_xlat16_7 = (-u_xlat0.x) + 2.0;
    u_xlat16_7 = u_xlat0.x * u_xlat16_7;
    u_xlat0.x = u_xlat16_7 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat0.x = min(u_xlat16_3, _HeigtFogColBase.w);
    u_xlat8.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat8.x * u_xlat4.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat5.x = u_xlat5.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat5.x = u_xlat5.x + _miHoYo_WindParams3.x;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _ObjectMoveScale;
    u_xlat10.x = (-u_xlat5.x) * u_xlat5.x + 1.0;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat5.x * u_xlat1.y + u_xlat10.x;
    u_xlat2.y = (-u_xlat5.x) * u_xlat1.x + u_xlat10.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat5.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat5.z;
    u_xlat1 = u_xlat5.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    u_xlat10.x = u_xlat0.z * _HeigtFogParams2.x;
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
    u_xlat15 = u_xlat10.x * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat10.x * u_xlat5.x;
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
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat5.x = u_xlat5.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat5.x = u_xlat5.x + _miHoYo_WindParams3.x;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _ObjectMoveScale;
    u_xlat10.x = (-u_xlat5.x) * u_xlat5.x + 1.0;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat5.x * u_xlat1.y + u_xlat10.x;
    u_xlat2.y = (-u_xlat5.x) * u_xlat1.x + u_xlat10.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat5.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat5.z;
    u_xlat1 = u_xlat5.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    u_xlat10.x = u_xlat0.z * _HeigtFogParams2.x;
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
    u_xlat15 = u_xlat10.x * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat10.x * u_xlat5.x;
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
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
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
uniform 	vec4 _miHoYo_WindParams3;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _Frequency;
uniform 	float _AmplitudeStrength;
uniform 	float _InvWaveLength;
uniform 	float _Fold;
uniform 	mediump float _ObjectMoveScale;
uniform 	mediump vec4 _ObjPivot;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0.xy = in_POSITION0.yy * hlslcc_mtx4x4unity_ObjectToWorld[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[0].xy * in_POSITION0.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[2].xy * in_POSITION0.zz + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_ObjectToWorld[3].xy * in_POSITION0.ww + u_xlat0.xy;
    u_xlat0.x = u_xlat0.x * _Fold + u_xlat0.y;
    u_xlat0.x = u_xlat0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat5.x = in_COLOR0.x * _AmplitudeStrength;
    u_xlat0.x = u_xlat0.x * u_xlat5.x;
    u_xlat5.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y + hlslcc_mtx4x4unity_ObjectToWorld[3].x;
    u_xlat5.x = u_xlat5.x + hlslcc_mtx4x4unity_ObjectToWorld[3].z;
    u_xlat5.x = u_xlat5.x + _miHoYo_WindParams3.x;
    u_xlat5.x = sin(u_xlat5.x);
    u_xlat5.x = u_xlat5.x * _ObjectMoveScale;
    u_xlat10.x = (-u_xlat5.x) * u_xlat5.x + 1.0;
    u_xlat10.x = sqrt(u_xlat10.x);
    u_xlat1.xyz = in_POSITION0.xyz + (-_ObjPivot.xyz);
    u_xlat10.xy = u_xlat10.xx * u_xlat1.xy;
    u_xlat2.x = u_xlat5.x * u_xlat1.y + u_xlat10.x;
    u_xlat2.y = (-u_xlat5.x) * u_xlat1.x + u_xlat10.y;
    u_xlat2.z = u_xlat1.z;
    u_xlat5.xyz = u_xlat2.yzx + _ObjPivot.yzx;
    u_xlat0.x = u_xlat0.x * in_TEXCOORD0.x + u_xlat5.z;
    u_xlat1 = u_xlat5.xxxx * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat5.yyyy + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
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
    u_xlat10.x = u_xlat0.z * _HeigtFogParams2.x;
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
    u_xlat15 = u_xlat10.x * -1.44269502;
    u_xlat5.z = exp2(u_xlat15);
    u_xlat5.xz = (-u_xlat5.xz) + vec2(1.0, 1.0);
    u_xlat15 = u_xlat5.z / u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.00999999978<abs(u_xlat10.x));
#else
    u_xlatb10 = 0.00999999978<abs(u_xlat10.x);
#endif
    u_xlat16_4 = (u_xlatb10) ? u_xlat15 : 1.0;
    u_xlat10.x = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat10.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat10.x = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
    u_xlat2.w = u_xlat10.x * u_xlat5.x;
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
uniform 	mediump vec4 _Color;
uniform 	float _LightMapIntensity;
uniform 	mediump float _Opaqueness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_1.xyz = u_xlat10_0.xyz + u_xlat10_0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat10_0.www) + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * _Color;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_0.w * _Opaqueness;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_1.xyz * vec3(_LightMapIntensity);
    u_xlat16_1.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = u_xlat0.xyz * u_xlat16_1.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_1.xyz;
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
Fallback "Diffuse"
}