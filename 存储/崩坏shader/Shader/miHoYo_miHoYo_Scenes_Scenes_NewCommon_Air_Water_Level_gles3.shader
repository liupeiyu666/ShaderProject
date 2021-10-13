//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Air_Water_Level" {
Properties {
_MianColor ("MianColor", Color) = (1,0,0,0)
_Opacity ("Opacity", Range(0, 1)) = 1
_DeepColor ("Deep Color", Color) = (0,0,0,0)
_ShalowColor ("Shalow Color", Color) = (1,1,1,0)
_WaterDepth ("Water Depth", Float) = 0
_WaterFalloff ("Water Falloff", Range(-1, 0)) = 0
_Distortion ("Distortion", Float) = 0.5
_DistortionOffset ("DistortionOffset", Vector) = (0,0,0,0)
_WaterNormal ("Water Normal", 2D) = "bump" { }
_WaterNormalSpeed ("WaterNormalSpeed", Vector) = (-0.03,0,0.04,0.04)
_NormalScale ("Normal Scale", Float) = 0
_WaterNormalMask ("Water NormalMask", 2D) = "white" { }
_NormalMaskScale ("NormalMaskScale", Float) = 1
_OffsetTex ("OffsetTex", 2D) = "white" { }
_OffsetSpeed ("OffsetSpeed", Vector) = (0,0,0,0)
_OffsetIntensity ("OffsetIntensity", Vector) = (0,0,0,0)
_DepthColor ("DepthColor", Color) = (0,0,0,0)
_DepthDistance ("DepthDistance", Float) = 0
_FogValue ("FogIntensity", Float) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 1711
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _OffsetTex_ST;
uniform 	vec2 _OffsetSpeed;
uniform 	vec3 _OffsetIntensity;
uniform lowp sampler2D _OffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = textureLod(_OffsetTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _OffsetIntensity.xyz;
    u_xlat0.xyz = in_COLOR0.xyz * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat12 = (-u_xlat1.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat4.x = max(u_xlat4.x, _FogEffectStart);
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthColor;
uniform 	vec4 _MianColor;
uniform 	vec4 _DeepColor;
uniform 	vec4 _ShalowColor;
uniform 	float _WaterDepth;
uniform 	float _WaterFalloff;
uniform 	float _NormalScale;
uniform 	vec4 _WaterNormalSpeed;
uniform 	float _NormalMaskScale;
uniform 	vec4 _WaterNormal_ST;
uniform 	float _Distortion;
uniform 	vec4 _DistortionOffset;
uniform 	float _DepthDistance;
uniform 	float _FogValue;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _WaterNormalMask;
uniform lowp sampler2D _WaterNormal;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat12;
float u_xlat18;
lowp float u_xlat10_18;
void main()
{
    u_xlat0 = vs_TEXCOORD0.xyxy * _WaterNormal_ST.xyxy + _WaterNormal_ST.zwzw;
    u_xlat0 = _Time.yyyy * _WaterNormalSpeed + u_xlat0;
    u_xlat10_1.xyz = texture(_WaterNormal, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_WaterNormal, u_xlat0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.z = u_xlat16_2.z * u_xlat16_3.z;
    u_xlat0.x = _NormalScale * 0.00999999978;
    u_xlat16_2.xy = u_xlat0.xx * u_xlat16_2.xy;
    u_xlat16_4.xy = u_xlat16_3.xy * u_xlat0.xx + u_xlat16_2.xy;
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat16_4.xy;
    u_xlat0.xy = u_xlat16_2.xy * vec2(_Distortion);
    u_xlat12.x = vs_TEXCOORD3.w * 0.5;
    u_xlat18 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat1.y = u_xlat18 * _ProjectionParams.x + u_xlat12.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat12.xy = u_xlat1.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.x = texture(_WaterNormalMask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat10_1.x * _NormalMaskScale;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xx + u_xlat12.xy;
    u_xlat0.xy = _DistortionOffset.xy * vec2(0.100000001, 0.100000001) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat1.xyz = vs_TEXCOORD3.xyz / vs_TEXCOORD3.www;
    u_xlat18 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD3.w);
    u_xlat18 = _WaterDepth * 100.0 + abs(u_xlat18);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _WaterFalloff;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat5.xyz = (-_DeepColor.xyz) + _ShalowColor.xyz;
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz + _DeepColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-u_xlat5.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _MianColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_DepthColor.xyz);
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.z * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = (-u_xlat1.x) + u_xlat18;
    u_xlat18 = u_xlat18 / _DepthDistance;
    u_xlat18 = min(abs(u_xlat18), 1.0);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _DepthColor.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR1.www;
    u_xlat0.xyz = vec3(vec3(_FogValue, _FogValue, _FogValue)) * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _OffsetTex_ST;
uniform 	vec2 _OffsetSpeed;
uniform 	vec3 _OffsetIntensity;
uniform lowp sampler2D _OffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = textureLod(_OffsetTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _OffsetIntensity.xyz;
    u_xlat0.xyz = in_COLOR0.xyz * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat12 = (-u_xlat1.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat4.x = max(u_xlat4.x, _FogEffectStart);
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthColor;
uniform 	vec4 _MianColor;
uniform 	vec4 _DeepColor;
uniform 	vec4 _ShalowColor;
uniform 	float _WaterDepth;
uniform 	float _WaterFalloff;
uniform 	float _NormalScale;
uniform 	vec4 _WaterNormalSpeed;
uniform 	float _NormalMaskScale;
uniform 	vec4 _WaterNormal_ST;
uniform 	float _Distortion;
uniform 	vec4 _DistortionOffset;
uniform 	float _DepthDistance;
uniform 	float _FogValue;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _WaterNormalMask;
uniform lowp sampler2D _WaterNormal;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat12;
float u_xlat18;
lowp float u_xlat10_18;
void main()
{
    u_xlat0 = vs_TEXCOORD0.xyxy * _WaterNormal_ST.xyxy + _WaterNormal_ST.zwzw;
    u_xlat0 = _Time.yyyy * _WaterNormalSpeed + u_xlat0;
    u_xlat10_1.xyz = texture(_WaterNormal, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_WaterNormal, u_xlat0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.z = u_xlat16_2.z * u_xlat16_3.z;
    u_xlat0.x = _NormalScale * 0.00999999978;
    u_xlat16_2.xy = u_xlat0.xx * u_xlat16_2.xy;
    u_xlat16_4.xy = u_xlat16_3.xy * u_xlat0.xx + u_xlat16_2.xy;
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat16_4.xy;
    u_xlat0.xy = u_xlat16_2.xy * vec2(_Distortion);
    u_xlat12.x = vs_TEXCOORD3.w * 0.5;
    u_xlat18 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat1.y = u_xlat18 * _ProjectionParams.x + u_xlat12.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat12.xy = u_xlat1.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.x = texture(_WaterNormalMask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat10_1.x * _NormalMaskScale;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xx + u_xlat12.xy;
    u_xlat0.xy = _DistortionOffset.xy * vec2(0.100000001, 0.100000001) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat1.xyz = vs_TEXCOORD3.xyz / vs_TEXCOORD3.www;
    u_xlat18 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD3.w);
    u_xlat18 = _WaterDepth * 100.0 + abs(u_xlat18);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _WaterFalloff;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat5.xyz = (-_DeepColor.xyz) + _ShalowColor.xyz;
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz + _DeepColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-u_xlat5.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _MianColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_DepthColor.xyz);
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.z * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = (-u_xlat1.x) + u_xlat18;
    u_xlat18 = u_xlat18 / _DepthDistance;
    u_xlat18 = min(abs(u_xlat18), 1.0);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _DepthColor.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR1.www;
    u_xlat0.xyz = vec3(vec3(_FogValue, _FogValue, _FogValue)) * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
uniform 	vec4 _ProjectionParams;
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
uniform 	vec4 _OffsetTex_ST;
uniform 	vec2 _OffsetSpeed;
uniform 	vec3 _OffsetIntensity;
uniform lowp sampler2D _OffsetTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xy = in_TEXCOORD0.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
    u_xlat0.xy = _Time.yy * _OffsetSpeed.xy + u_xlat0.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat8 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat8 * 0.5;
    vs_TEXCOORD3.xy = u_xlat2.zz + u_xlat2.xw;
    u_xlat0.xyz = textureLod(_OffsetTex, u_xlat0.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * _OffsetIntensity.xyz;
    u_xlat0.xyz = in_COLOR0.xyz * u_xlat0.xyz + in_POSITION0.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb12 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb12){
        u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
        u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat2.xyz;
        u_xlat2.xyz = u_xlat2.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
        u_xlat12 = sqrt(u_xlat12);
        u_xlat12 = u_xlat12 + (-_FogStartDistance);
        u_xlat12 = max(u_xlat12, 0.0);
        u_xlat1.xy = vec2(u_xlat12) * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat12 = (-u_xlat1.x) + 1.0;
        u_xlat12 = u_xlat12 * _FogEffectLimit;
        u_xlat12 = max(u_xlat12, _FogEffectStart);
        u_xlat2.w = min(u_xlat12, _FogEffectLimit);
        u_xlat3.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat3.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    } else {
        u_xlat2.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
        u_xlat0.xyw = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
        u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
        u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
        u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = u_xlat0.x + (-_FogStartDistance);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.xy = u_xlat0.xx * vec2(_FogIntensity, _FogColorIntensity);
        u_xlat0.xy = u_xlat0.xy * vec2(500.0, 1000.0);
        u_xlat8 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat8 = max(u_xlat8, 0.100000001);
        u_xlat0.xy = u_xlat0.yx / vec2(u_xlat8);
        u_xlat4.x = u_xlat0.y * _FogEffectLimit;
        u_xlat4.x = max(u_xlat4.x, _FogEffectStart);
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3.zw = u_xlat1.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _ZBufferParams;
uniform 	float _Opacity;
uniform 	vec4 _DepthColor;
uniform 	vec4 _MianColor;
uniform 	vec4 _DeepColor;
uniform 	vec4 _ShalowColor;
uniform 	float _WaterDepth;
uniform 	float _WaterFalloff;
uniform 	float _NormalScale;
uniform 	vec4 _WaterNormalSpeed;
uniform 	float _NormalMaskScale;
uniform 	vec4 _WaterNormal_ST;
uniform 	float _Distortion;
uniform 	vec4 _DistortionOffset;
uniform 	float _DepthDistance;
uniform 	float _FogValue;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _WaterNormalMask;
uniform lowp sampler2D _WaterNormal;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _CustomDepthTexture;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
vec2 u_xlat12;
float u_xlat18;
lowp float u_xlat10_18;
void main()
{
    u_xlat0 = vs_TEXCOORD0.xyxy * _WaterNormal_ST.xyxy + _WaterNormal_ST.zwzw;
    u_xlat0 = _Time.yyyy * _WaterNormalSpeed + u_xlat0;
    u_xlat10_1.xyz = texture(_WaterNormal, u_xlat0.xy).xyz;
    u_xlat10_0.xyz = texture(_WaterNormal, u_xlat0.zw).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_4.z = u_xlat16_2.z * u_xlat16_3.z;
    u_xlat0.x = _NormalScale * 0.00999999978;
    u_xlat16_2.xy = u_xlat0.xx * u_xlat16_2.xy;
    u_xlat16_4.xy = u_xlat16_3.xy * u_xlat0.xx + u_xlat16_2.xy;
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat16_4.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xy = u_xlat16_2.xx * u_xlat16_4.xy;
    u_xlat0.xy = u_xlat16_2.xy * vec2(_Distortion);
    u_xlat12.x = vs_TEXCOORD3.w * 0.5;
    u_xlat18 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat1.y = u_xlat18 * _ProjectionParams.x + u_xlat12.x;
    u_xlat1.x = vs_TEXCOORD3.x;
    u_xlat12.xy = u_xlat1.xy / vs_TEXCOORD3.ww;
    u_xlat10_1.x = texture(_WaterNormalMask, vs_TEXCOORD0.xy).x;
    u_xlat1.x = u_xlat10_1.x * _NormalMaskScale;
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xx + u_xlat12.xy;
    u_xlat0.xy = _DistortionOffset.xy * vec2(0.100000001, 0.100000001) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat1.xyz = vs_TEXCOORD3.xyz / vs_TEXCOORD3.www;
    u_xlat18 = texture(_CameraDepthTexture, u_xlat1.xy).x;
    u_xlat18 = _ZBufferParams.z * u_xlat18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = u_xlat18 + (-vs_TEXCOORD3.w);
    u_xlat18 = _WaterDepth * 100.0 + abs(u_xlat18);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _WaterFalloff;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, 1.0);
    u_xlat5.xyz = (-_DeepColor.xyz) + _ShalowColor.xyz;
    u_xlat5.xyz = vec3(u_xlat18) * u_xlat5.xyz + _DeepColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz + (-u_xlat5.xyz);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + u_xlat5.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _MianColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-_DepthColor.xyz);
    u_xlat10_18 = texture(_CustomDepthTexture, u_xlat1.xy).x;
    u_xlat1.x = u_xlat1.z * 0.5 + 0.5;
    u_xlat1.x = _ZBufferParams.z * u_xlat1.x + _ZBufferParams.w;
    u_xlat1.x = float(1.0) / u_xlat1.x;
    u_xlat18 = _ZBufferParams.z * u_xlat10_18 + _ZBufferParams.w;
    u_xlat18 = float(1.0) / u_xlat18;
    u_xlat18 = (-u_xlat1.x) + u_xlat18;
    u_xlat18 = u_xlat18 / _DepthDistance;
    u_xlat18 = min(abs(u_xlat18), 1.0);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz + _DepthColor.xyz;
    u_xlat16_2.xyz = (-u_xlat0.xyz) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vs_COLOR1.www;
    u_xlat0.xyz = vec3(vec3(_FogValue, _FogValue, _FogValue)) * u_xlat16_2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _Opacity;
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
CustomEditor "ASEMaterialInspector"
}