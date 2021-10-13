//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/EffectUnderSeaScene_CutOff" {
Properties {
_EmissionScaler ("Emission Scaler", Float) = 1
_MainTex ("Base(R) Mask(G) Trans (A)", 2D) = "white" { }
_BaseColor ("Base Color", Color) = (1,1,1,1)
_UpColor ("Up Color", Color) = (1,1,1,1)
_MaskColor ("Mask Color", Color) = (1,1,1,1)
_MaskScale ("Mask Scale", Float) = 1
_Magnitude ("Distortion Magnitude", Float) = 1
_Frequency ("Distortion Frequency", Float) = 1
_InvWaveLength ("Distortion Inverse Wave Length", Float) = 10
_Normal_Scale ("Normal Scale", Float) = 1
_Magnitude1 ("Distortion Magnitude normal", Float) = 1
_Frequency1 ("Distortion Frequency normal", Float) = 1
_USpeed ("Main Tex U Speed", Float) = 1
_VSpeed ("Main Tex V Speed", Float) = 1
_FlowMap ("FlowMap(RG)", 2D) = "white" { }
_Speed ("Speed", Range(0, 1)) = 0.4
_FlowIntensity ("FlowIntensity", Range(0, 1)) = 0.25
_FlowSignX ("FlowSignX", Range(-1, 1)) = 1
_FlowSignY ("FlowSignY", Range(-1, 1)) = -1
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceVAnimClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceVAnimClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 65169
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat23;
float u_xlat24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat24 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xyz;
    u_xlat9 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat1.w = u_xlat2.x * u_xlat2.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat23;
float u_xlat24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat24 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xyz;
    u_xlat9 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat1.w = u_xlat2.x * u_xlat2.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat23;
float u_xlat24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat24 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xyz;
    u_xlat9 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat1.w = u_xlat2.x * u_xlat2.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat21;
float u_xlat23;
float u_xlat26;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat26) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat3.xzw;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat5.x = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat12 = u_xlat5.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5.x));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5.x);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat12 : 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat5.x) + 2.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat5.x;
    u_xlat5.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat5.x = u_xlat5.x + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat5.x = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat12 = (-u_xlat5.x) + 1.0;
    u_xlat3.xzw = u_xlat3.xzw * vec3(u_xlat12);
    u_xlat1.w = u_xlat23 * u_xlat12;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat5.xxx + u_xlat3.xzw;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat23) + 2.0;
    u_xlat16_4 = u_xlat23 * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat5.x;
    u_xlat5.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb10) ? u_xlat5.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xzw;
    u_xlat9 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.w = u_xlat2.x * u_xlat2.w;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat21;
float u_xlat23;
float u_xlat26;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat26) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat3.xzw;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat5.x = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat12 = u_xlat5.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5.x));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5.x);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat12 : 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat5.x) + 2.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat5.x;
    u_xlat5.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat5.x = u_xlat5.x + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat5.x = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat12 = (-u_xlat5.x) + 1.0;
    u_xlat3.xzw = u_xlat3.xzw * vec3(u_xlat12);
    u_xlat1.w = u_xlat23 * u_xlat12;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat5.xxx + u_xlat3.xzw;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat23) + 2.0;
    u_xlat16_4 = u_xlat23 * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat5.x;
    u_xlat5.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb10) ? u_xlat5.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xzw;
    u_xlat9 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.w = u_xlat2.x * u_xlat2.w;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat21;
float u_xlat23;
float u_xlat26;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat26) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat3.xzw;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat5.x = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat12 = u_xlat5.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5.x));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5.x);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat12 : 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat5.x) + 2.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat5.x;
    u_xlat5.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat5.x = u_xlat5.x + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat5.x = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat12 = (-u_xlat5.x) + 1.0;
    u_xlat3.xzw = u_xlat3.xzw * vec3(u_xlat12);
    u_xlat1.w = u_xlat23 * u_xlat12;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat5.xxx + u_xlat3.xzw;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat23) + 2.0;
    u_xlat16_4 = u_xlat23 * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat5.x;
    u_xlat5.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb10) ? u_xlat5.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xzw;
    u_xlat9 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.w = u_xlat2.x * u_xlat2.w;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat28 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat28 = u_xlat28 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat11 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat1.w = u_xlat3.x * u_xlat3.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat28 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat28 = u_xlat28 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat11 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat1.w = u_xlat3.x * u_xlat3.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat28 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat28 = u_xlat28 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat11 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat1.w = u_xlat3.x * u_xlat3.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat30;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta3.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor3.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase3.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat30 = u_xlat26 + (-_HeigtFogRamp3.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat30) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat4.xzw;
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat6.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat14 = u_xlat6.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6.x));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6.x);
#endif
    u_xlat16_5 = (u_xlatb6) ? u_xlat14 : 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat6.x) + 2.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat6.x;
    u_xlat6.x = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat6.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat14 = (-u_xlat6.x) + 1.0;
    u_xlat4.xzw = u_xlat4.xzw * vec3(u_xlat14);
    u_xlat1.w = u_xlat27 * u_xlat14;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat6.xxx + u_xlat4.xzw;
    u_xlat27 = u_xlat2.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat27) + 2.0;
    u_xlat16_5 = u_xlat27 * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat27 = u_xlat26 + (-_HeigtFogRamp2.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat27 = u_xlat26 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat6.x;
    u_xlat6.x = u_xlat27 * _HeigtFogColDelta2.w;
    u_xlat27 = (u_xlatb12) ? u_xlat6.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor2.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase2.w);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xzw;
    u_xlat11 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams2.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat3.w = u_xlat3.x * u_xlat3.w;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat3);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat30;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta3.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor3.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase3.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat30 = u_xlat26 + (-_HeigtFogRamp3.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat30) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat4.xzw;
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat6.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat14 = u_xlat6.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6.x));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6.x);
#endif
    u_xlat16_5 = (u_xlatb6) ? u_xlat14 : 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat6.x) + 2.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat6.x;
    u_xlat6.x = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat6.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat14 = (-u_xlat6.x) + 1.0;
    u_xlat4.xzw = u_xlat4.xzw * vec3(u_xlat14);
    u_xlat1.w = u_xlat27 * u_xlat14;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat6.xxx + u_xlat4.xzw;
    u_xlat27 = u_xlat2.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat27) + 2.0;
    u_xlat16_5 = u_xlat27 * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat27 = u_xlat26 + (-_HeigtFogRamp2.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat27 = u_xlat26 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat6.x;
    u_xlat6.x = u_xlat27 * _HeigtFogColDelta2.w;
    u_xlat27 = (u_xlatb12) ? u_xlat6.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor2.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase2.w);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xzw;
    u_xlat11 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams2.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat3.w = u_xlat3.x * u_xlat3.w;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat3);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat30;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta3.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor3.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase3.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat30 = u_xlat26 + (-_HeigtFogRamp3.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat30) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat4.xzw;
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat6.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat14 = u_xlat6.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6.x));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6.x);
#endif
    u_xlat16_5 = (u_xlatb6) ? u_xlat14 : 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat6.x) + 2.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat6.x;
    u_xlat6.x = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat6.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat14 = (-u_xlat6.x) + 1.0;
    u_xlat4.xzw = u_xlat4.xzw * vec3(u_xlat14);
    u_xlat1.w = u_xlat27 * u_xlat14;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat6.xxx + u_xlat4.xzw;
    u_xlat27 = u_xlat2.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat27) + 2.0;
    u_xlat16_5 = u_xlat27 * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat27 = u_xlat26 + (-_HeigtFogRamp2.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat27 = u_xlat26 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat6.x;
    u_xlat6.x = u_xlat27 * _HeigtFogColDelta2.w;
    u_xlat27 = (u_xlatb12) ? u_xlat6.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor2.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase2.w);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xzw;
    u_xlat11 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams2.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat3.w = u_xlat3.x * u_xlat3.w;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat3);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    SV_Target0.xyz = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_1.xzw = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_1.xzw = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_1.xzw = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_1.xzw = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_1.xzw = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
vec3 u_xlat11;
float u_xlat19;
float u_xlat27;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat3.x = u_xlat3.x * _FogEffectLimit;
        u_xlat3.x = max(u_xlat3.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat3.x, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat19 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat19 = max(u_xlat19, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat19);
        u_xlat11.x = u_xlat3.y * _FogEffectLimit;
        u_xlat11.x = max(u_xlat11.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat11.x, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat3.x = (-u_xlat3.x) + 1.0;
        u_xlat11.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat3.xxx * u_xlat11.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat27 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat3.xyz = vec3(u_xlat27) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    gl_Position = u_xlat0;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_1.xzw = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat23;
float u_xlat24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat24 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xyz;
    u_xlat9 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat1.w = u_xlat2.x * u_xlat2.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat23;
float u_xlat24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat24 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xyz;
    u_xlat9 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat1.w = u_xlat2.x * u_xlat2.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat21;
float u_xlat23;
float u_xlat24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xyz = vec3(u_xlat16_4) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat5.xyz = (-u_xlat3.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat24 = u_xlat21 + (-_HeigtFogRamp.w);
    u_xlat24 = u_xlat24 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat5.xyz + u_xlat3.xyz;
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xyz;
    u_xlat9 = u_xlat2.y * _HeigtFogParams.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat1.w = u_xlat2.x * u_xlat2.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat21;
float u_xlat23;
float u_xlat26;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat26) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat3.xzw;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat5.x = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat12 = u_xlat5.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5.x));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5.x);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat12 : 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat5.x) + 2.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat5.x;
    u_xlat5.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat5.x = u_xlat5.x + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat5.x = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat12 = (-u_xlat5.x) + 1.0;
    u_xlat3.xzw = u_xlat3.xzw * vec3(u_xlat12);
    u_xlat1.w = u_xlat23 * u_xlat12;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat5.xxx + u_xlat3.xzw;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat23) + 2.0;
    u_xlat16_4 = u_xlat23 * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat5.x;
    u_xlat5.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb10) ? u_xlat5.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xzw;
    u_xlat9 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.w = u_xlat2.x * u_xlat2.w;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat21;
float u_xlat23;
float u_xlat26;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat26) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat3.xzw;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat5.x = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat12 = u_xlat5.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5.x));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5.x);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat12 : 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat5.x) + 2.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat5.x;
    u_xlat5.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat5.x = u_xlat5.x + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat5.x = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat12 = (-u_xlat5.x) + 1.0;
    u_xlat3.xzw = u_xlat3.xzw * vec3(u_xlat12);
    u_xlat1.w = u_xlat23 * u_xlat12;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat5.xxx + u_xlat3.xzw;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat23) + 2.0;
    u_xlat16_4 = u_xlat23 * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat5.x;
    u_xlat5.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb10) ? u_xlat5.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xzw;
    u_xlat9 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.w = u_xlat2.x * u_xlat2.w;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
mediump float u_xlat16_4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec2 u_xlat16_6;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
bool u_xlatb10;
mediump float u_xlat16_11;
float u_xlat12;
float u_xlat21;
float u_xlat23;
float u_xlat26;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat21 = _Time.y * _Frequency1;
    u_xlat21 = sin(u_xlat21);
    u_xlat21 = u_xlat21 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat21)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat2.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat21 = sqrt(u_xlat21);
    u_xlat23 = u_xlat21 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat3.x;
    u_xlat3.x = u_xlat23 * _HeigtFogColDelta3.w;
    u_xlat10 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(u_xlat21>=u_xlat10);
#else
    u_xlatb10 = u_xlat21>=u_xlat10;
#endif
    u_xlat23 = (u_xlatb10) ? u_xlat3.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor3.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat23 = min(u_xlat23, _HeigtFogColBase3.w);
    u_xlat3.x = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat3.x) + 2.0;
    u_xlat16_4 = u_xlat3.x * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat26 = u_xlat21 + (-_HeigtFogRamp3.w);
    u_xlat26 = u_xlat26 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat26) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat3.xzw;
    u_xlat23 = (-u_xlat23) + 1.0;
    u_xlat5.x = u_xlat2.y * _HeigtFogParams3.x;
    u_xlat12 = u_xlat5.x * -1.44269502;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = (-u_xlat12) + 1.0;
    u_xlat12 = u_xlat12 / u_xlat5.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0.00999999978<abs(u_xlat5.x));
#else
    u_xlatb5 = 0.00999999978<abs(u_xlat5.x);
#endif
    u_xlat16_4 = (u_xlatb5) ? u_xlat12 : 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogParams3.y;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat5.x = u_xlat21 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat5.x = min(max(u_xlat5.x, 0.0), 1.0);
#else
    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat5.x) + 2.0;
    u_xlat16_11 = u_xlat16_11 * u_xlat5.x;
    u_xlat5.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat5.x = u_xlat5.x + 1.0;
    u_xlat16_4 = u_xlat16_4 * u_xlat5.x;
    u_xlat5.x = min(u_xlat16_4, _HeigtFogColBase3.w);
    u_xlat12 = (-u_xlat5.x) + 1.0;
    u_xlat3.xzw = u_xlat3.xzw * vec3(u_xlat12);
    u_xlat1.w = u_xlat23 * u_xlat12;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat5.xxx + u_xlat3.xzw;
    u_xlat23 = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat16_4 = (-u_xlat23) + 2.0;
    u_xlat16_4 = u_xlat23 * u_xlat16_4;
    u_xlat3.xzw = vec3(u_xlat16_4) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat5.xyz = (-u_xlat3.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat23 = u_xlat21 + (-_HeigtFogRamp2.w);
    u_xlat23 = u_xlat23 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat3.xzw = vec3(u_xlat23) * u_xlat5.xyz + u_xlat3.xzw;
    u_xlat23 = u_xlat21 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat23 = min(max(u_xlat23, 0.0), 1.0);
#else
    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
#endif
    u_xlat5.x = (-u_xlat23) + 2.0;
    u_xlat23 = u_xlat23 * u_xlat5.x;
    u_xlat5.x = u_xlat23 * _HeigtFogColDelta2.w;
    u_xlat23 = (u_xlatb10) ? u_xlat5.x : u_xlat23;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Mihoyo_FogColor2.w;
    u_xlat23 = exp2(u_xlat23);
    u_xlat2.w = min(u_xlat23, _HeigtFogColBase2.w);
    u_xlat3.xyz = u_xlat2.www * u_xlat3.xzw;
    u_xlat9 = u_xlat2.y * _HeigtFogParams2.x;
    u_xlat5.xz = (-u_xlat2.xz) * vec2(_CamDistRatio) + u_xlat0.xz;
    u_xlat2.x = u_xlat9 * -1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.xw = (-u_xlat2.xw) + vec2(1.0, 1.0);
    u_xlat2.x = u_xlat2.x / u_xlat9;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(0.00999999978<abs(u_xlat9));
#else
    u_xlatb9 = 0.00999999978<abs(u_xlat9);
#endif
    u_xlat16_4 = (u_xlatb9) ? u_xlat2.x : 1.0;
    u_xlat2.x = u_xlat21 * _HeigtFogParams2.y;
    u_xlat21 = u_xlat21 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat16_4 = u_xlat2.x * u_xlat16_4;
    u_xlat16_4 = exp2((-u_xlat16_4));
    u_xlat16_4 = min(u_xlat16_4, 1.0);
    u_xlat16_4 = (-u_xlat16_4) + 1.0;
    u_xlat16_11 = (-u_xlat21) + 2.0;
    u_xlat16_11 = u_xlat21 * u_xlat16_11;
    u_xlat21 = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat21 = u_xlat21 + 1.0;
    u_xlat16_4 = u_xlat21 * u_xlat16_4;
    u_xlat21 = min(u_xlat16_4, _HeigtFogColBase2.w);
    u_xlat2.x = (-u_xlat21) + 1.0;
    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
    u_xlat2.w = u_xlat2.x * u_xlat2.w;
    u_xlat2.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat21) + u_xlat3.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat2);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat2;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat5.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat5.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat2.y = u_xlat0.y;
    u_xlat16_4 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat3.x = (-u_xlat16_4);
    u_xlat16_6.y = u_xlat16_4;
    u_xlat2.x = dot(u_xlat16_6.xy, u_xlat0.xz);
    u_xlat3.y = u_xlat16_6.x;
    u_xlat2.z = dot(u_xlat3.xy, u_xlat0.xz);
    vs_TEXCOORD3.xyz = u_xlat2.xyz;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
lowp vec2 u_xlat10_5;
float u_xlat10;
mediump vec2 u_xlat16_11;
float u_xlat15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat10 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat15 = fract(u_xlat10);
    u_xlat10 = u_xlat10 + 0.5;
    u_xlat10 = fract(u_xlat10);
    u_xlat16_11.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_11.xy = u_xlat16_11.xy + u_xlat16_11.xy;
    u_xlat16_11.xy = vec2(u_xlat16_11.x * float(_FlowSignX), u_xlat16_11.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_11.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_11.xy = u_xlat0.xy * vec2(u_xlat15) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat10) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat15 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_5.xy = texture(_MainTex, u_xlat16_11.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_5.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_5.xy;
    u_xlat16_11.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_11.x = u_xlat16_11.x + 1.0;
    u_xlat16_11.x = floor(u_xlat16_11.x);
    u_xlat16_11.x = max(u_xlat16_11.x, 0.0);
    u_xlati0 = int(u_xlat16_11.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_11.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_11.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_17 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_17 = u_xlat16_17 + u_xlat16_17;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_17)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
    u_xlat16_2.x = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xxx + vs_COLOR1.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
mediump vec2 u_xlat16_6;
vec3 u_xlat7;
float u_xlat8;
float u_xlat24;
bool u_xlatb24;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat8 = _Time.y * _Frequency1;
    u_xlat0.y = sin(u_xlat8);
    u_xlat0.xy = u_xlat0.xy * vec2(_Magnitude, _Magnitude1);
    u_xlat1.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat1.z = 0.0;
    u_xlat16_2.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xzw = u_xlat1.xyz * u_xlat16_2.xxx + in_POSITION0.xyz;
    u_xlat16_2.xyz = abs(u_xlat0.yyy) * in_NORMAL0.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_2.xyz * in_COLOR0.yyy + u_xlat0.xzw;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat2.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb24 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb24){
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * (-u_xlat3.xy);
        u_xlat3.xy = u_xlat3.xy * vec2(1.44269502, 1.44269502);
        u_xlat3.xy = exp2(u_xlat3.xy);
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat24 = u_xlat24 * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = u_xlat3.yyy * u_xlat3.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    } else {
        u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
        u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
        u_xlat3.xyz = u_xlat3.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat24 = u_xlat24 + (-_FogStartDistance);
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat3.xy = vec2(u_xlat24) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat3.xy = u_xlat3.xy * vec2(500.0, 1000.0);
        u_xlat24 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat24 = max(u_xlat24, 0.100000001);
        u_xlat3.xy = u_xlat3.yx / vec2(u_xlat24);
        u_xlat24 = u_xlat3.y * _FogEffectLimit;
        u_xlat24 = max(u_xlat24, _FogEffectStart);
        u_xlat4.w = min(u_xlat24, _FogEffectLimit);
        u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
        u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
        u_xlat24 = (-u_xlat3.x) + 1.0;
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat4.xyz = vec3(u_xlat24) * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat4;
    //ENDIF
    }
    u_xlat3.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat3.xyz;
    u_xlat4.xy = u_xlat3.xz + (-_WorldSpaceCameraPos.xz);
    u_xlat4.xz = (-u_xlat4.xy) * vec2(_CamDistRatio) + u_xlat3.xz;
    u_xlat4.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat3.xyz = u_xlat3.xyz + (-u_xlat4.xyz);
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_6.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_6.y = u_xlat16_5;
    u_xlat7.x = dot(u_xlat16_6.xy, u_xlat3.xz);
    u_xlat4.y = u_xlat16_6.x;
    u_xlat7.z = dot(u_xlat4.xy, u_xlat3.xz);
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat3.xz = u_xlat0.xy + (-_WorldSpaceCameraPos.xz);
    u_xlat3.x = dot(u_xlat3.xz, u_xlat3.xz);
    u_xlat3.x = sqrt(u_xlat3.x);
    u_xlat3.x = u_xlat3.x + (-_UWFogDistStart);
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.xz = u_xlat3.xx * vec2(_UWFogDensity, _UWFogColorNFIntensity);
    u_xlat3.xz = u_xlat3.xz * (-u_xlat3.xz);
    u_xlat3.xz = u_xlat3.xz * vec2(1.44269502, 1.44269502);
    u_xlat0.xy = exp2(u_xlat3.xz);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = u_xlat0.x * _UWFogEffectLimit;
    u_xlat0.x = max(u_xlat0.x, _UWFogEffectStart);
    u_xlat0.z = min(u_xlat0.x, _UWFogEffectLimit);
    gl_Position = u_xlat1;
    phase0_Output0_1 = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat7.y = u_xlat3.y;
    vs_TEXCOORD3.xyz = u_xlat7.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat28 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat28 = u_xlat28 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat11 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat1.w = u_xlat3.x * u_xlat3.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat28 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat28 = u_xlat28 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat11 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat1.w = u_xlat3.x * u_xlat3.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat28;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat6.xyz = (-u_xlat4.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat28 = u_xlat26 + (-_HeigtFogRamp.w);
    u_xlat28 = u_xlat28 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat4.xyz = vec3(u_xlat28) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xyz;
    u_xlat11 = u_xlat3.y * _HeigtFogParams.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat1.w = u_xlat3.x * u_xlat3.w;
    u_xlat1.xyz = _Mihoyo_FogColor.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat30;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta3.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor3.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase3.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat30 = u_xlat26 + (-_HeigtFogRamp3.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat30) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat4.xzw;
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat6.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat14 = u_xlat6.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6.x));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6.x);
#endif
    u_xlat16_5 = (u_xlatb6) ? u_xlat14 : 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat6.x) + 2.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat6.x;
    u_xlat6.x = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat6.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat14 = (-u_xlat6.x) + 1.0;
    u_xlat4.xzw = u_xlat4.xzw * vec3(u_xlat14);
    u_xlat1.w = u_xlat27 * u_xlat14;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat6.xxx + u_xlat4.xzw;
    u_xlat27 = u_xlat2.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat27) + 2.0;
    u_xlat16_5 = u_xlat27 * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat27 = u_xlat26 + (-_HeigtFogRamp2.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat27 = u_xlat26 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat6.x;
    u_xlat6.x = u_xlat27 * _HeigtFogColDelta2.w;
    u_xlat27 = (u_xlatb12) ? u_xlat6.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor2.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase2.w);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xzw;
    u_xlat11 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams2.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat3.w = u_xlat3.x * u_xlat3.w;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat3);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat30;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta3.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor3.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase3.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat30 = u_xlat26 + (-_HeigtFogRamp3.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat30) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat4.xzw;
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat6.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat14 = u_xlat6.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6.x));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6.x);
#endif
    u_xlat16_5 = (u_xlatb6) ? u_xlat14 : 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat6.x) + 2.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat6.x;
    u_xlat6.x = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat6.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat14 = (-u_xlat6.x) + 1.0;
    u_xlat4.xzw = u_xlat4.xzw * vec3(u_xlat14);
    u_xlat1.w = u_xlat27 * u_xlat14;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat6.xxx + u_xlat4.xzw;
    u_xlat27 = u_xlat2.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat27) + 2.0;
    u_xlat16_5 = u_xlat27 * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat27 = u_xlat26 + (-_HeigtFogRamp2.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat27 = u_xlat26 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat6.x;
    u_xlat6.x = u_xlat27 * _HeigtFogColDelta2.w;
    u_xlat27 = (u_xlatb12) ? u_xlat6.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor2.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase2.w);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xzw;
    u_xlat11 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams2.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat3.w = u_xlat3.x * u_xlat3.w;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat3);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform 	float _UWFogColorNFIntensity;
uniform 	float _UWFogDensity;
uniform 	float _UWFogEffectStart;
uniform 	float _UWFogEffectLimit;
uniform 	float _UWFogDistStart;
uniform 	vec4 _MainTex_ST;
uniform 	float _Magnitude;
uniform 	float _Frequency;
uniform 	float _InvWaveLength;
uniform 	float _Magnitude1;
uniform 	float _Frequency1;
uniform 	mediump float _Normal_Scale;
uniform 	mediump float _CamDistRatio;
uniform 	mediump float _CamHeightOffset;
uniform 	mediump float _CamRotate;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
in mediump vec4 in_NORMAL0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_1;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_COLOR1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
bool u_xlatb6;
mediump vec2 u_xlat16_7;
float u_xlat11;
bool u_xlatb11;
float u_xlat12;
bool u_xlatb12;
mediump float u_xlat16_13;
float u_xlat14;
float u_xlat24;
float u_xlat26;
float u_xlat27;
float u_xlat30;
void main()
{
    u_xlat0.x = in_POSITION0.x * _InvWaveLength;
    u_xlat0.x = _Frequency * _Time.y + u_xlat0.x;
    u_xlat0.x = in_POSITION0.y * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = in_POSITION0.z * _InvWaveLength + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Magnitude;
    u_xlat0.xy = u_xlat0.xx * in_COLOR0.xx;
    u_xlat0.z = 0.0;
    u_xlat16_1.x = (-in_COLOR0.y) + 1.0;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_1.xxx + in_POSITION0.xyz;
    u_xlat24 = _Time.y * _Frequency1;
    u_xlat24 = sin(u_xlat24);
    u_xlat24 = u_xlat24 * _Magnitude1;
    u_xlat16_1.xyz = abs(vec3(u_xlat24)) * in_NORMAL0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Normal_Scale);
    u_xlat0.xyz = u_xlat16_1.xyz * in_COLOR0.yyy + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[3].xzy * in_POSITION0.www + u_xlat0.xzy;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat1.zw = in_TEXCOORD1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    phase0_Output0_1 = u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat2.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
    u_xlat3.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat26 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat26 = sqrt(u_xlat26);
    u_xlat27 = u_xlat26 * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat4.x;
    u_xlat4.x = u_xlat27 * _HeigtFogColDelta3.w;
    u_xlat12 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat26>=u_xlat12);
#else
    u_xlatb12 = u_xlat26>=u_xlat12;
#endif
    u_xlat27 = (u_xlatb12) ? u_xlat4.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor3.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = min(u_xlat27, _HeigtFogColBase3.w);
    u_xlat4.x = u_xlat2.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.x = min(max(u_xlat4.x, 0.0), 1.0);
#else
    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat4.x) + 2.0;
    u_xlat16_5 = u_xlat4.x * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat30 = u_xlat26 + (-_HeigtFogRamp3.w);
    u_xlat30 = u_xlat30 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat30 = min(max(u_xlat30, 0.0), 1.0);
#else
    u_xlat30 = clamp(u_xlat30, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat30) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat4.xzw;
    u_xlat27 = (-u_xlat27) + 1.0;
    u_xlat6.x = u_xlat3.y * _HeigtFogParams3.x;
    u_xlat14 = u_xlat6.x * -1.44269502;
    u_xlat14 = exp2(u_xlat14);
    u_xlat14 = (-u_xlat14) + 1.0;
    u_xlat14 = u_xlat14 / u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6.x));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6.x);
#endif
    u_xlat16_5 = (u_xlatb6) ? u_xlat14 : 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat6.x = u_xlat26 * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat16_13 = (-u_xlat6.x) + 2.0;
    u_xlat16_13 = u_xlat16_13 * u_xlat6.x;
    u_xlat6.x = u_xlat16_13 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat6.x = u_xlat6.x + 1.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat6.x;
    u_xlat6.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat14 = (-u_xlat6.x) + 1.0;
    u_xlat4.xzw = u_xlat4.xzw * vec3(u_xlat14);
    u_xlat1.w = u_xlat27 * u_xlat14;
    u_xlat1.xyz = _Mihoyo_FogColor3.xyz * u_xlat6.xxx + u_xlat4.xzw;
    u_xlat27 = u_xlat2.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat27) + 2.0;
    u_xlat16_5 = u_xlat27 * u_xlat16_5;
    u_xlat4.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat6.xyz = (-u_xlat4.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat27 = u_xlat26 + (-_HeigtFogRamp2.w);
    u_xlat27 = u_xlat27 * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat4.xzw = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xzw;
    u_xlat27 = u_xlat26 * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.x = (-u_xlat27) + 2.0;
    u_xlat27 = u_xlat27 * u_xlat6.x;
    u_xlat6.x = u_xlat27 * _HeigtFogColDelta2.w;
    u_xlat27 = (u_xlatb12) ? u_xlat6.x : u_xlat27;
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _Mihoyo_FogColor2.w;
    u_xlat27 = exp2(u_xlat27);
    u_xlat3.w = min(u_xlat27, _HeigtFogColBase2.w);
    u_xlat4.xyz = u_xlat3.www * u_xlat4.xzw;
    u_xlat11 = u_xlat3.y * _HeigtFogParams2.x;
    u_xlat6.xz = (-u_xlat3.xz) * vec2(_CamDistRatio) + u_xlat2.xz;
    u_xlat3.x = u_xlat11 * -1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.xw = (-u_xlat3.xw) + vec2(1.0, 1.0);
    u_xlat3.x = u_xlat3.x / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlatb11 = !!(0.00999999978<abs(u_xlat11));
#else
    u_xlatb11 = 0.00999999978<abs(u_xlat11);
#endif
    u_xlat16_5 = (u_xlatb11) ? u_xlat3.x : 1.0;
    u_xlat3.x = u_xlat26 * _HeigtFogParams2.y;
    u_xlat26 = u_xlat26 * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_13 = (-u_xlat26) + 2.0;
    u_xlat16_13 = u_xlat26 * u_xlat16_13;
    u_xlat26 = u_xlat16_13 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat26 = u_xlat26 + 1.0;
    u_xlat16_5 = u_xlat26 * u_xlat16_5;
    u_xlat26 = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat3.x = (-u_xlat26) + 1.0;
    u_xlat4.xyz = u_xlat3.xxx * u_xlat4.xyz;
    u_xlat3.w = u_xlat3.x * u_xlat3.w;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * vec3(u_xlat26) + u_xlat4.xyz;
    u_xlat1 = u_xlat1 + (-u_xlat3);
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    vs_TEXCOORD2.xyz = in_NORMAL0.xyz;
    u_xlat6.y = _WorldSpaceCameraPos.y + _CamHeightOffset;
    u_xlat2.xyz = u_xlat2.xyz + (-u_xlat6.xyz);
    u_xlat26 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat26 = inversesqrt(u_xlat26);
    u_xlat2.xyz = vec3(u_xlat26) * u_xlat2.xyz;
    u_xlat3.y = u_xlat2.y;
    u_xlat16_5 = sin(_CamRotate);
    u_xlat16_7.x = cos(_CamRotate);
    u_xlat4.x = (-u_xlat16_5);
    u_xlat16_7.y = u_xlat16_5;
    u_xlat3.x = dot(u_xlat16_7.xy, u_xlat2.xz);
    u_xlat4.y = u_xlat16_7.x;
    u_xlat3.z = dot(u_xlat4.xy, u_xlat2.xz);
    vs_TEXCOORD3.xyz = u_xlat3.xyz;
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
    vs_TEXCOORD4.xyz = u_xlat0.yzw;
vs_TEXCOORD0 = phase0_Output0_1.xy;
vs_TEXCOORD1 = phase0_Output0_1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
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
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _BaseColor;
uniform 	mediump vec4 _UpColor;
uniform 	mediump vec4 _MaskColor;
uniform 	mediump float _MaskScale;
uniform 	float _USpeed;
uniform 	float _VSpeed;
uniform 	mediump float _Reflectivity;
uniform 	float _Speed;
uniform 	float _FlowIntensity;
uniform 	float _FlowSignX;
uniform 	float _FlowSignY;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FlowMap;
uniform lowp sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_COLOR1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
int u_xlati0;
bool u_xlatb0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
lowp vec2 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat6;
lowp vec2 u_xlat10_6;
vec3 u_xlat9;
float u_xlat12;
mediump vec2 u_xlat16_13;
float u_xlat18;
bool u_xlatb18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat0.xy;
    u_xlat16_1.xy = vec2(_USpeed, _VSpeed) * _Time.yy + u_xlat16_1.xy;
    u_xlat10_0.xyz = texture(_FlowMap, u_xlat16_1.xy).xyz;
    u_xlat12 = _Speed * _Time.y + u_xlat10_0.z;
    u_xlat18 = fract(u_xlat12);
    u_xlat12 = u_xlat12 + 0.5;
    u_xlat12 = fract(u_xlat12);
    u_xlat16_13.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_13.xy = u_xlat16_13.xy + u_xlat16_13.xy;
    u_xlat16_13.xy = vec2(u_xlat16_13.x * float(_FlowSignX), u_xlat16_13.y * float(_FlowSignY));
    u_xlat0.xy = u_xlat16_13.xy * vec2(vec2(_FlowIntensity, _FlowIntensity));
    u_xlat16_13.xy = u_xlat0.xy * vec2(u_xlat18) + u_xlat16_1.xy;
    u_xlat16_1.xy = u_xlat0.xy * vec2(u_xlat12) + u_xlat16_1.xy;
    u_xlat16_2.x = u_xlat18 + -0.5;
    u_xlat16_0.x = u_xlat16_2.x + u_xlat16_2.x;
    u_xlat10_6.xy = texture(_MainTex, u_xlat16_13.xy).xw;
    u_xlat10_3.xy = texture(_MainTex, u_xlat16_1.xy).xw;
    u_xlat16_1.xy = (-u_xlat10_6.xy) + u_xlat10_3.xy;
    u_xlat16_1.xy = abs(u_xlat16_0.xx) * u_xlat16_1.xy + u_xlat10_6.xy;
    u_xlat16_13.x = u_xlat16_1.y + (-_Cutoff);
    u_xlat16_13.x = u_xlat16_13.x + 1.0;
    u_xlat16_13.x = floor(u_xlat16_13.x);
    u_xlat16_13.x = max(u_xlat16_13.x, 0.0);
    u_xlati0 = int(u_xlat16_13.x);
    if((u_xlati0)==0){discard;}
    u_xlat16_13.x = u_xlat16_1.x * vs_COLOR0.x;
    u_xlat16_2.xyz = (-_BaseColor.xyz) + _UpColor.xyz;
    u_xlat16_2.xyz = u_xlat16_13.xxx * u_xlat16_2.xyz + _BaseColor.xyz;
    u_xlat16_1.x = u_xlat16_1.x * _EmissionScaler + 1.0;
    u_xlat16_1.xzw = u_xlat16_1.xxx * u_xlat16_2.xyz;
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD1.xy).y;
    u_xlat16_2.xyz = u_xlat10_0.xxx * _MaskColor.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(_MaskScale) + vec3(1.0, 1.0, 1.0);
    u_xlat16_20 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_20 = u_xlat16_20 + u_xlat16_20;
    u_xlat16_4.xyz = vs_TEXCOORD2.xyz * (-vec3(u_xlat16_20)) + vs_TEXCOORD3.xyz;
    u_xlat10_0.xyz = texture(_EnvTex, u_xlat16_4.xyz).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_Reflectivity);
    u_xlat16_4.xyz = vs_COLOR0.xxx * (-u_xlat16_0.xyz) + u_xlat16_0.xyz;
    u_xlat16_1.xzw = u_xlat16_1.xzw * u_xlat16_2.xyz + u_xlat16_4.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(_WaterPlaneHeight<vs_TEXCOORD4.z);
#else
    u_xlatb0 = _WaterPlaneHeight<vs_TEXCOORD4.z;
#endif
    u_xlat16_2.xyz = (-u_xlat16_1.xzw) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_1.xzw;
    u_xlat6.x = (-vs_TEXCOORD4.z) + _WaterPlaneHeight;
    u_xlat12 = (-_UWFogHeightEnd) + _WaterPlaneHeight;
    u_xlat6.x = u_xlat6.x / u_xlat12;
    u_xlat6.x = max(u_xlat6.x, 0.0);
    u_xlat3.x = u_xlat6.x * _UWFogColorHLIntensity;
    u_xlat12 = (-_UWHeightFogDensity) * u_xlat6.x + 1.0;
    u_xlat12 = u_xlat12 * _UWHeightFogEffectLimit;
    u_xlat12 = max(u_xlat12, _UWHeightFogEffectStart);
    u_xlat12 = min(u_xlat12, _UWHeightFogEffectLimit);
    u_xlat3.x = u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.99000001<vs_TEXCOORD4.y);
#else
    u_xlatb18 = 0.99000001<vs_TEXCOORD4.y;
#endif
    u_xlat6.x = (-u_xlat6.x) * _UWHeightRatio + 1.0;
    u_xlat6.x = u_xlat6.x * vs_TEXCOORD4.y;
    u_xlat6.x = max(u_xlat6.x, _UWCriticalRange);
    u_xlat6.x = min(u_xlat6.x, 1.0);
    u_xlat16_20 = (u_xlatb18) ? u_xlat6.x : vs_TEXCOORD4.y;
    u_xlat16_20 = (-u_xlat16_20) + 1.0;
    u_xlat9.xyz = _UWFogColorNear.xyz + (-_UWFogColorFar.xyz);
    u_xlat9.xyz = vs_TEXCOORD4.xxx * u_xlat9.xyz + _UWFogColorFar.xyz;
    u_xlat5.xyz = u_xlat16_1.xzw + (-u_xlat9.xyz);
    u_xlat9.xyz = vec3(u_xlat16_20) * u_xlat5.xyz + u_xlat9.xyz;
    u_xlat5.xyz = _UWFogColorHigh.xyz + (-_UWFogColorLow.xyz);
    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz + _UWFogColorLow.xyz;
    u_xlat3.xyz = u_xlat9.xyz + (-u_xlat5.xyz);
    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz + u_xlat5.xyz;
    u_xlat16_1.xzw = (bool(u_xlatb0)) ? u_xlat16_2.xyz : u_xlat6.xyz;
    u_xlat16_0.x = dot(u_xlat16_1.xzw, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_1.xzw) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_1.xzw;
    SV_Target0.xyz = u_xlat16_0.xyz;
    SV_Target0.w = u_xlat16_1.y;
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
}