//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/TreeLeavesDyanmic" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 0
_BendScale ("Bend Scale", Range(0, 0.1)) = 0.01
_UpDownScale ("UpDown Scale", Range(0, 0.5)) = 0.1
_WiggleScale ("WiggleScale Scale", Range(0, 0.5)) = 0.1
_ObjectColor ("Object Color", Color) = (1,1,1,1)
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 32941
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat6;
vec2 u_xlat7;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6 = u_xlat0.y * _BendScale + 1.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat6 + (-u_xlat6);
    u_xlat0.xz = _miHoYo_Wind.xz * vec2(u_xlat6) + u_xlat0.xz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat16 = u_xlat2.y * 0.100000001;
    u_xlat7.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat3.y = u_xlat7.x + in_COLOR0.y;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat3.yyy);
    u_xlat3 = u_xlat3.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat3 = u_xlat3 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat3 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.xy = vec2(u_xlat3.y + u_xlat3.x, u_xlat3.w + u_xlat3.z);
    u_xlat16 = u_xlat16 * in_COLOR0.x;
    u_xlat3.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat0.xyz = u_xlat7.xxx * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat16 = u_xlat7.y * in_COLOR0.z;
    u_xlat5 = u_xlat16 * u_xlat2.x + u_xlat0.y;
    u_xlat2 = vec4(u_xlat5) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb10 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb10){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * (-u_xlat10.xy);
        u_xlat10.xy = u_xlat10.xy * vec2(1.44269502, 1.44269502);
        u_xlat10.xy = exp2(u_xlat10.xy);
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat10.x = u_xlat10.x * _FogEffectLimit;
        u_xlat10.x = max(u_xlat10.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat10.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat10.xy = u_xlat10.yx / vec2(u_xlat16);
        u_xlat15 = u_xlat10.y * _FogEffectLimit;
        u_xlat15 = max(u_xlat15, _FogEffectStart);
        u_xlat2.w = min(u_xlat15, _FogEffectLimit);
        u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat6;
vec2 u_xlat7;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6 = u_xlat0.y * _BendScale + 1.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat6 + (-u_xlat6);
    u_xlat0.xz = _miHoYo_Wind.xz * vec2(u_xlat6) + u_xlat0.xz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat16 = u_xlat2.y * 0.100000001;
    u_xlat7.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat3.y = u_xlat7.x + in_COLOR0.y;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat3.yyy);
    u_xlat3 = u_xlat3.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat3 = u_xlat3 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat3 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.xy = vec2(u_xlat3.y + u_xlat3.x, u_xlat3.w + u_xlat3.z);
    u_xlat16 = u_xlat16 * in_COLOR0.x;
    u_xlat3.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat0.xyz = u_xlat7.xxx * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat16 = u_xlat7.y * in_COLOR0.z;
    u_xlat5 = u_xlat16 * u_xlat2.x + u_xlat0.y;
    u_xlat2 = vec4(u_xlat5) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb10 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb10){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * (-u_xlat10.xy);
        u_xlat10.xy = u_xlat10.xy * vec2(1.44269502, 1.44269502);
        u_xlat10.xy = exp2(u_xlat10.xy);
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat10.x = u_xlat10.x * _FogEffectLimit;
        u_xlat10.x = max(u_xlat10.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat10.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat10.xy = u_xlat10.yx / vec2(u_xlat16);
        u_xlat15 = u_xlat10.y * _FogEffectLimit;
        u_xlat15 = max(u_xlat15, _FogEffectStart);
        u_xlat2.w = min(u_xlat15, _FogEffectLimit);
        u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat6;
vec2 u_xlat7;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6 = u_xlat0.y * _BendScale + 1.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat6 + (-u_xlat6);
    u_xlat0.xz = _miHoYo_Wind.xz * vec2(u_xlat6) + u_xlat0.xz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat16 = u_xlat2.y * 0.100000001;
    u_xlat7.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat3.y = u_xlat7.x + in_COLOR0.y;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat3.yyy);
    u_xlat3 = u_xlat3.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat3 = u_xlat3 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat3 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.xy = vec2(u_xlat3.y + u_xlat3.x, u_xlat3.w + u_xlat3.z);
    u_xlat16 = u_xlat16 * in_COLOR0.x;
    u_xlat3.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat0.xyz = u_xlat7.xxx * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat16 = u_xlat7.y * in_COLOR0.z;
    u_xlat5 = u_xlat16 * u_xlat2.x + u_xlat0.y;
    u_xlat2 = vec4(u_xlat5) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb10 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb10){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * (-u_xlat10.xy);
        u_xlat10.xy = u_xlat10.xy * vec2(1.44269502, 1.44269502);
        u_xlat10.xy = exp2(u_xlat10.xy);
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat10.x = u_xlat10.x * _FogEffectLimit;
        u_xlat10.x = max(u_xlat10.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat10.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat10.xy = u_xlat10.yx / vec2(u_xlat16);
        u_xlat15 = u_xlat10.y * _FogEffectLimit;
        u_xlat15 = max(u_xlat15, _FogEffectStart);
        u_xlat2.w = min(u_xlat15, _FogEffectLimit);
        u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat6;
vec2 u_xlat7;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6 = u_xlat0.y * _BendScale + 1.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat6 + (-u_xlat6);
    u_xlat0.xz = _miHoYo_Wind.xz * vec2(u_xlat6) + u_xlat0.xz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat16 = u_xlat2.y * 0.100000001;
    u_xlat7.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat3.y = u_xlat7.x + in_COLOR0.y;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat3.yyy);
    u_xlat3 = u_xlat3.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat3 = u_xlat3 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat3 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.xy = vec2(u_xlat3.y + u_xlat3.x, u_xlat3.w + u_xlat3.z);
    u_xlat16 = u_xlat16 * in_COLOR0.x;
    u_xlat3.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat0.xyz = u_xlat7.xxx * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat16 = u_xlat7.y * in_COLOR0.z;
    u_xlat5 = u_xlat16 * u_xlat2.x + u_xlat0.y;
    u_xlat2 = vec4(u_xlat5) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb10 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb10){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * (-u_xlat10.xy);
        u_xlat10.xy = u_xlat10.xy * vec2(1.44269502, 1.44269502);
        u_xlat10.xy = exp2(u_xlat10.xy);
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat10.x = u_xlat10.x * _FogEffectLimit;
        u_xlat10.x = max(u_xlat10.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat10.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat10.xy = u_xlat10.yx / vec2(u_xlat16);
        u_xlat15 = u_xlat10.y * _FogEffectLimit;
        u_xlat15 = max(u_xlat15, _FogEffectStart);
        u_xlat2.w = min(u_xlat15, _FogEffectLimit);
        u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat6;
vec2 u_xlat7;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6 = u_xlat0.y * _BendScale + 1.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat6 + (-u_xlat6);
    u_xlat0.xz = _miHoYo_Wind.xz * vec2(u_xlat6) + u_xlat0.xz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat16 = u_xlat2.y * 0.100000001;
    u_xlat7.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat3.y = u_xlat7.x + in_COLOR0.y;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat3.yyy);
    u_xlat3 = u_xlat3.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat3 = u_xlat3 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat3 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.xy = vec2(u_xlat3.y + u_xlat3.x, u_xlat3.w + u_xlat3.z);
    u_xlat16 = u_xlat16 * in_COLOR0.x;
    u_xlat3.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat0.xyz = u_xlat7.xxx * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat16 = u_xlat7.y * in_COLOR0.z;
    u_xlat5 = u_xlat16 * u_xlat2.x + u_xlat0.y;
    u_xlat2 = vec4(u_xlat5) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb10 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb10){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * (-u_xlat10.xy);
        u_xlat10.xy = u_xlat10.xy * vec2(1.44269502, 1.44269502);
        u_xlat10.xy = exp2(u_xlat10.xy);
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat10.x = u_xlat10.x * _FogEffectLimit;
        u_xlat10.x = max(u_xlat10.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat10.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat10.xy = u_xlat10.yx / vec2(u_xlat16);
        u_xlat15 = u_xlat10.y * _FogEffectLimit;
        u_xlat15 = max(u_xlat15, _FogEffectStart);
        u_xlat2.w = min(u_xlat15, _FogEffectLimit);
        u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec3 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
float u_xlat5;
float u_xlat6;
vec2 u_xlat7;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6 = u_xlat0.y * _BendScale + 1.0;
    u_xlat6 = u_xlat6 * u_xlat6;
    u_xlat6 = u_xlat6 * u_xlat6 + (-u_xlat6);
    u_xlat0.xz = _miHoYo_Wind.xz * vec2(u_xlat6) + u_xlat0.xz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat6);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat1.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat1.xyz;
    u_xlat2.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat16 = u_xlat2.y * 0.100000001;
    u_xlat7.x = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat3.y = u_xlat7.x + in_COLOR0.y;
    u_xlat3.x = dot(u_xlat0.xyz, u_xlat3.yyy);
    u_xlat3 = u_xlat3.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat3 = u_xlat3 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = u_xlat3 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat7.xy = vec2(u_xlat3.y + u_xlat3.x, u_xlat3.w + u_xlat3.z);
    u_xlat16 = u_xlat16 * in_COLOR0.x;
    u_xlat3.xyz = u_xlat1.xyz * vec3(u_xlat16);
    u_xlat0.xyz = u_xlat7.xxx * u_xlat3.xyz + u_xlat0.xyz;
    u_xlat16 = u_xlat7.y * in_COLOR0.z;
    u_xlat5 = u_xlat16 * u_xlat2.x + u_xlat0.y;
    u_xlat2 = vec4(u_xlat5) * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat2;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb10 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb10){
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * (-u_xlat10.xy);
        u_xlat10.xy = u_xlat10.xy * vec2(1.44269502, 1.44269502);
        u_xlat10.xy = exp2(u_xlat10.xy);
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat10.x = u_xlat10.x * _FogEffectLimit;
        u_xlat10.x = max(u_xlat10.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat10.x, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat10.x = sqrt(u_xlat10.x);
        u_xlat10.x = u_xlat10.x + (-_FogStartDistance);
        u_xlat10.x = max(u_xlat10.x, 0.0);
        u_xlat10.xy = u_xlat10.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat10.xy = u_xlat10.xy * vec2(500.0, 1000.0);
        u_xlat16 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat16 = max(u_xlat16, 0.100000001);
        u_xlat10.xy = u_xlat10.yx / vec2(u_xlat16);
        u_xlat15 = u_xlat10.y * _FogEffectLimit;
        u_xlat15 = max(u_xlat15, _FogEffectStart);
        u_xlat2.w = min(u_xlat15, _FogEffectLimit);
        u_xlat10.x = u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat10.x = min(max(u_xlat10.x, 0.0), 1.0);
#else
        u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
#endif
        u_xlat10.x = (-u_xlat10.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat10.xxx * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat16 = u_xlat1.y * _BendScale + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = u_xlat16 * u_xlat16 + (-u_xlat16);
    u_xlat2.xz = _miHoYo_Wind.xz * vec2(u_xlat16) + u_xlat1.xz;
    u_xlat2.y = u_xlat1.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat16 = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat2.y = u_xlat16 + in_COLOR0.y;
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat2.yyy);
    u_xlat2 = u_xlat2.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat2 = u_xlat2 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2.xy = vec2(u_xlat2.y + u_xlat2.x, u_xlat2.w + u_xlat2.z);
    u_xlat16 = u_xlat2.y * in_COLOR0.z;
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat3.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat8.x = u_xlat3.y * 0.100000001;
    u_xlat8.x = u_xlat8.x * in_COLOR0.x;
    u_xlat8.xyz = u_xlat7.xyz * u_xlat8.xxx;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat16 * u_xlat3.x + u_xlat1.y;
    u_xlat2 = u_xlat6.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat16 = u_xlat1.y * _BendScale + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = u_xlat16 * u_xlat16 + (-u_xlat16);
    u_xlat2.xz = _miHoYo_Wind.xz * vec2(u_xlat16) + u_xlat1.xz;
    u_xlat2.y = u_xlat1.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat16 = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat2.y = u_xlat16 + in_COLOR0.y;
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat2.yyy);
    u_xlat2 = u_xlat2.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat2 = u_xlat2 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2.xy = vec2(u_xlat2.y + u_xlat2.x, u_xlat2.w + u_xlat2.z);
    u_xlat16 = u_xlat2.y * in_COLOR0.z;
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat3.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat8.x = u_xlat3.y * 0.100000001;
    u_xlat8.x = u_xlat8.x * in_COLOR0.x;
    u_xlat8.xyz = u_xlat7.xyz * u_xlat8.xxx;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat16 * u_xlat3.x + u_xlat1.y;
    u_xlat2 = u_xlat6.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
mediump float u_xlat16_9;
vec2 u_xlat10;
bool u_xlatb10;
float u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat16 = u_xlat1.y * _BendScale + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = u_xlat16 * u_xlat16 + (-u_xlat16);
    u_xlat2.xz = _miHoYo_Wind.xz * vec2(u_xlat16) + u_xlat1.xz;
    u_xlat2.y = u_xlat1.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat16 = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat2.y = u_xlat16 + in_COLOR0.y;
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat2.yyy);
    u_xlat2 = u_xlat2.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat2 = u_xlat2 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2.xy = vec2(u_xlat2.y + u_xlat2.x, u_xlat2.w + u_xlat2.z);
    u_xlat16 = u_xlat2.y * in_COLOR0.z;
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat3.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat8.x = u_xlat3.y * 0.100000001;
    u_xlat8.x = u_xlat8.x * in_COLOR0.x;
    u_xlat8.xyz = u_xlat7.xyz * u_xlat8.xxx;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat16 * u_xlat3.x + u_xlat1.y;
    u_xlat2 = u_xlat6.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
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
    u_xlat16_4 = (u_xlatb5) ? u_xlat15 : 1.0;
    u_xlat5 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat5 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_4 = u_xlat0.x * u_xlat16_4;
    u_xlat0.x = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat5 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat5) * u_xlat1.xyz;
    u_xlat2.w = u_xlat5 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat16 = u_xlat1.y * _BendScale + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = u_xlat16 * u_xlat16 + (-u_xlat16);
    u_xlat2.xz = _miHoYo_Wind.xz * vec2(u_xlat16) + u_xlat1.xz;
    u_xlat2.y = u_xlat1.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat16 = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat2.y = u_xlat16 + in_COLOR0.y;
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat2.yyy);
    u_xlat2 = u_xlat2.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat2 = u_xlat2 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2.xy = vec2(u_xlat2.y + u_xlat2.x, u_xlat2.w + u_xlat2.z);
    u_xlat16 = u_xlat2.y * in_COLOR0.z;
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat3.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat8.x = u_xlat3.y * 0.100000001;
    u_xlat8.x = u_xlat8.x * in_COLOR0.x;
    u_xlat8.xyz = u_xlat7.xyz * u_xlat8.xxx;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat16 * u_xlat3.x + u_xlat1.y;
    u_xlat2 = u_xlat6.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
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
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat16 = u_xlat1.y * _BendScale + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = u_xlat16 * u_xlat16 + (-u_xlat16);
    u_xlat2.xz = _miHoYo_Wind.xz * vec2(u_xlat16) + u_xlat1.xz;
    u_xlat2.y = u_xlat1.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat16 = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat2.y = u_xlat16 + in_COLOR0.y;
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat2.yyy);
    u_xlat2 = u_xlat2.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat2 = u_xlat2 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2.xy = vec2(u_xlat2.y + u_xlat2.x, u_xlat2.w + u_xlat2.z);
    u_xlat16 = u_xlat2.y * in_COLOR0.z;
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat3.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat8.x = u_xlat3.y * 0.100000001;
    u_xlat8.x = u_xlat8.x * in_COLOR0.x;
    u_xlat8.xyz = u_xlat7.xyz * u_xlat8.xxx;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat16 * u_xlat3.x + u_xlat1.y;
    u_xlat2 = u_xlat6.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
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
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
uniform 	vec4 _miHoYo_Wind;
uniform 	vec4 _miHoYo_WindParams3;
uniform 	vec4 _MainTex_ST;
uniform 	float _BendScale;
uniform 	float _UpDownScale;
uniform 	float _WiggleScale;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out highp vec3 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
bool u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
vec3 u_xlat7;
vec3 u_xlat8;
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
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat1.xyz = u_xlat0.xyz + (-hlslcc_mtx4x4unity_ObjectToWorld[3].xyz);
    u_xlat16 = u_xlat1.y * _BendScale + 1.0;
    u_xlat16 = u_xlat16 * u_xlat16;
    u_xlat16 = u_xlat16 * u_xlat16 + (-u_xlat16);
    u_xlat2.xz = _miHoYo_Wind.xz * vec2(u_xlat16) + u_xlat1.xz;
    u_xlat2.y = u_xlat1.y;
    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xyz = u_xlat6.xxx * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat6.xyz * u_xlat1.xxx + hlslcc_mtx4x4unity_ObjectToWorld[3].xyz;
    u_xlat16 = dot(hlslcc_mtx4x4unity_ObjectToWorld[3].xyz, vec3(1.0, 1.0, 1.0));
    u_xlat2.y = u_xlat16 + in_COLOR0.y;
    u_xlat2.x = dot(u_xlat1.xyz, u_xlat2.yyy);
    u_xlat2 = u_xlat2.xxyy + _miHoYo_WindParams3.xxxx;
    u_xlat2 = u_xlat2 * vec4(1.97500002, 0.792999983, 0.375, 0.193000004);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = u_xlat2 * vec4(0.5, 0.5, 0.5, 0.5) + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat2 = fract(u_xlat2);
    u_xlat2 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat3 = abs(u_xlat2) * abs(u_xlat2);
    u_xlat2 = -abs(u_xlat2) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat2 = u_xlat3 * u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat2.xy = vec2(u_xlat2.y + u_xlat2.x, u_xlat2.w + u_xlat2.z);
    u_xlat16 = u_xlat2.y * in_COLOR0.z;
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat3.xy = vec2(_miHoYo_WindParams3.y * float(_UpDownScale), _miHoYo_WindParams3.y * float(_WiggleScale));
    u_xlat8.x = u_xlat3.y * 0.100000001;
    u_xlat8.x = u_xlat8.x * in_COLOR0.x;
    u_xlat8.xyz = u_xlat7.xyz * u_xlat8.xxx;
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat8.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat16 * u_xlat3.x + u_xlat1.y;
    u_xlat2 = u_xlat6.xxxx * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_COLOR0 = in_COLOR0;
    u_xlat15 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat15) + 2.0;
    u_xlat16_4 = u_xlat15 * u_xlat16_4;
    u_xlat1.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
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
    u_xlat16_4 = (u_xlatb16) ? u_xlat7.x : 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat16 = min(max(u_xlat16, 0.0), 1.0);
#else
    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat16) + 2.0;
    u_xlat16_9 = u_xlat16 * u_xlat16_9;
    u_xlat16 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat16 = u_xlat16 + 1.0;
    u_xlat16_4 = u_xlat16 * u_xlat16_4;
    u_xlat16 = min(u_xlat16_4, _HeigtFogColBase3.w);
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
uniform 	mediump float _Cutoff;
uniform 	mediump float _BloomFactor;
uniform 	vec3 _ObjectColor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
vec3 u_xlat2;
int u_xlati9;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.x = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
    u_xlat16_1.x = floor(u_xlat16_1.x);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
    u_xlati9 = int(u_xlat16_1.x);
    if((u_xlati9)==0){discard;}
    u_xlat0.xyz = u_xlat10_0.xyz * _ObjectColor.xyz;
    u_xlat2.xyz = u_xlat0.xyz * vs_COLOR0.www;
    u_xlat16_1.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_1.xyz + u_xlat2.xyz;
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
}
}
}
}