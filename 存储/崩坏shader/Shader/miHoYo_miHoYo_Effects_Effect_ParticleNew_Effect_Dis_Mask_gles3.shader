//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Dis_Mask" {
Properties {
_EnvColor ("Env Color", Color) = (1,1,1,1)
_MainSmokeTexture ("MainSmokeTexture", 2D) = "white" { }
_SmokeBrightness ("SmokeBrightness", Float) = 1
_Opacity ("Opacity", Range(0, 1)) = 1
_DisTexture ("DisTexture", 2D) = "white" { }
_DisUvR ("DisUv (R)", Vector) = (0,0,0,0)
_DisUvG ("DisUv(G)", Vector) = (0,0,1,1)
_DisNoise ("DisNoise", Range(-5, 2)) = -1
_DarkDisCt ("DarkDisCt", Range(-2, 0)) = 0
_Smoothstep ("Smoothstep", Range(0.5, 1)) = 0.5
_LightColor ("LightColor", Color) = (1,1,1,1)
_DarkColor ("DarkColor", Color) = (1,1,1,0)
[Toggle(_RIM_SWITCH_ON)] _Rim_Switch ("Rim_Switch", Float) = 0
_Rim ("Rim", Range(-0.1, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,0)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
[Toggle(RIM_GLOW)] _RimGlow ("Rim Glow", Float) = 0
_RGColor ("Rim Glow Color", Color) = (1,1,1,1)
_RGShininess ("Rim Glow Shininess", Float) = 1
_RGScale ("Rim Glow Scale", Float) = 1
_RGBias ("Rim Glow Bias", Float) = 0
_RGRatio ("Rim Glow Ratio", Range(0, 1)) = 0.5
_RGBloomFactor ("Rim Glow Bloom Factor", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(1, 9)) = 5
_DTPlaySpeed ("Distortion Play Speed", Float) = 0
_DTNormalDisplacment ("Distortion Normal Displacment", Float) = 0
_DTUVScaleInX ("Distortion UV Scale in X", Float) = 1
_DTUVScaleInY ("Distortion UV Scale in Y", Float) = 1
_DTFresnel ("Distortion Fresnel Params", Vector) = (1,1,0,0)
[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Keep = 0, Replace = 2", Float) = 2
}
SubShader {
 LOD 100
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 58080
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
lowp float u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_1.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_1.x = u_xlat10_5 * u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.y = u_xlat16_1.x + _DarkDisCt;
    u_xlat16_1.z = u_xlat16_1.y + _Rim;
    u_xlat16_16 = (-_Smoothstep) + 1.0;
    u_xlat16_1.xyz = (-vec3(u_xlat16_16)) + u_xlat16_1.xyz;
    u_xlat16_2 = (-u_xlat16_16) + _Smoothstep;
    u_xlat16_2 = float(1.0) / u_xlat16_2;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_2);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_1.z * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_1.z * u_xlat16_1.z;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_7.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_0.x * _DarkColor.xxyz.y, u_xlat10_0.y * _DarkColor.xxyz.z, u_xlat10_0.z * float(_DarkColor.z));
    u_xlat16_3.xyz = u_xlat10_0.xyz * _RimColor.xyz + (-u_xlat16_7.xyz);
    u_xlat16_0 = u_xlat10_0 * _LightColor;
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0<_Rim_Switch);
#else
    u_xlatb4 = 0.0<_Rim_Switch;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb4)) ? u_xlat16_3.xyz : u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-u_xlat16_7.xyz);
    u_xlat16_11 = u_xlat16_1.y * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_1.y * u_xlat16_1.y;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_SmokeBrightness);
    SV_Target0.xyz = u_xlat16_6.xyz * _EnvColor.xyz;
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
    u_xlat16_1.x = u_xlat16_0.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _Opacity;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
lowp float u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_1.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_1.x = u_xlat10_5 * u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.y = u_xlat16_1.x + _DarkDisCt;
    u_xlat16_1.z = u_xlat16_1.y + _Rim;
    u_xlat16_16 = (-_Smoothstep) + 1.0;
    u_xlat16_1.xyz = (-vec3(u_xlat16_16)) + u_xlat16_1.xyz;
    u_xlat16_2 = (-u_xlat16_16) + _Smoothstep;
    u_xlat16_2 = float(1.0) / u_xlat16_2;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_2);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_1.z * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_1.z * u_xlat16_1.z;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_7.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_0.x * _DarkColor.xxyz.y, u_xlat10_0.y * _DarkColor.xxyz.z, u_xlat10_0.z * float(_DarkColor.z));
    u_xlat16_3.xyz = u_xlat10_0.xyz * _RimColor.xyz + (-u_xlat16_7.xyz);
    u_xlat16_0 = u_xlat10_0 * _LightColor;
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0<_Rim_Switch);
#else
    u_xlatb4 = 0.0<_Rim_Switch;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb4)) ? u_xlat16_3.xyz : u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-u_xlat16_7.xyz);
    u_xlat16_11 = u_xlat16_1.y * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_1.y * u_xlat16_1.y;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_SmokeBrightness);
    SV_Target0.xyz = u_xlat16_6.xyz * _EnvColor.xyz;
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
    u_xlat16_1.x = u_xlat16_0.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _Opacity;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_2;
mediump vec3 u_xlat16_3;
bool u_xlatb4;
lowp float u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_1.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_1.x = u_xlat10_5 * u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.y = u_xlat16_1.x + _DarkDisCt;
    u_xlat16_1.z = u_xlat16_1.y + _Rim;
    u_xlat16_16 = (-_Smoothstep) + 1.0;
    u_xlat16_1.xyz = (-vec3(u_xlat16_16)) + u_xlat16_1.xyz;
    u_xlat16_2 = (-u_xlat16_16) + _Smoothstep;
    u_xlat16_2 = float(1.0) / u_xlat16_2;
    u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(u_xlat16_2);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_1.z * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_1.z * u_xlat16_1.z;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_7.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_0.x * _DarkColor.xxyz.y, u_xlat10_0.y * _DarkColor.xxyz.z, u_xlat10_0.z * float(_DarkColor.z));
    u_xlat16_3.xyz = u_xlat10_0.xyz * _RimColor.xyz + (-u_xlat16_7.xyz);
    u_xlat16_0 = u_xlat10_0 * _LightColor;
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0<_Rim_Switch);
#else
    u_xlatb4 = 0.0<_Rim_Switch;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb4)) ? u_xlat16_3.xyz : u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-u_xlat16_7.xyz);
    u_xlat16_11 = u_xlat16_1.y * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_1.y * u_xlat16_1.y;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_SmokeBrightness);
    SV_Target0.xyz = u_xlat16_6.xyz * _EnvColor.xyz;
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
    u_xlat16_1.x = u_xlat16_0.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _Opacity;
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
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat16_2.x * _RGRatio;
    u_xlat10_10 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_15 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_10 = u_xlat10_15 + u_xlat10_10;
    u_xlat16_2.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_15 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_2.x = u_xlat10_15 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_2.y = u_xlat16_2.x + _DarkDisCt;
    u_xlat16_2.z = u_xlat16_2.y + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_2.xyz = (-vec3(u_xlat16_17)) + u_xlat16_2.xyz;
    u_xlat16_3 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_2.z * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_2.z * u_xlat16_2.z;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_8.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_8.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_4.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_4.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_Rim_Switch);
#else
    u_xlatb10 = 0.0<_Rim_Switch;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb10)) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_8.xyz);
    u_xlat16_12 = u_xlat16_2.y * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = u_xlat16_7.xyz * _EnvColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat16_2.x * _RGRatio;
    u_xlat10_10 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_15 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_10 = u_xlat10_15 + u_xlat10_10;
    u_xlat16_2.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_15 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_2.x = u_xlat10_15 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_2.y = u_xlat16_2.x + _DarkDisCt;
    u_xlat16_2.z = u_xlat16_2.y + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_2.xyz = (-vec3(u_xlat16_17)) + u_xlat16_2.xyz;
    u_xlat16_3 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_2.z * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_2.z * u_xlat16_2.z;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_8.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_8.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_4.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_4.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_Rim_Switch);
#else
    u_xlatb10 = 0.0<_Rim_Switch;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb10)) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_8.xyz);
    u_xlat16_12 = u_xlat16_2.y * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = u_xlat16_7.xyz * _EnvColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
float u_xlat5;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump float u_xlat16_10;
lowp float u_xlat10_10;
bool u_xlatb10;
mediump float u_xlat16_12;
float u_xlat15;
lowp float u_xlat10_15;
mediump float u_xlat16_17;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
    u_xlat15 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat16_2.x * _RGRatio;
    u_xlat10_10 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_15 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_10 = u_xlat10_15 + u_xlat10_10;
    u_xlat16_2.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_15 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_2.x = u_xlat10_15 * u_xlat16_10 + u_xlat16_2.x;
    u_xlat16_2.y = u_xlat16_2.x + _DarkDisCt;
    u_xlat16_2.z = u_xlat16_2.y + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_2.xyz = (-vec3(u_xlat16_17)) + u_xlat16_2.xyz;
    u_xlat16_3 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_2.z * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_2.z * u_xlat16_2.z;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_8.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_8.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_4.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_8.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_4.xyz + u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb10 = !!(0.0<_Rim_Switch);
#else
    u_xlatb10 = 0.0<_Rim_Switch;
#endif
    u_xlat16_8.xyz = (bool(u_xlatb10)) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_8.xyz);
    u_xlat16_12 = u_xlat16_2.y * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_12;
    u_xlat16_7.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = u_xlat16_7.xyz * _EnvColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_7.xyz);
    u_xlat0.xyz = vec3(u_xlat5) * u_xlat0.xzw + u_xlat16_7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_7.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat11;
ivec2 u_xlati11;
lowp float u_xlat10_14;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat8.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat4 = u_xlat21 * 1.70000005 + (-u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat21 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati11.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat0.x = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_7 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_7.x = u_xlat10_14 + u_xlat10_7;
    u_xlat16_23 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_23 = u_xlat10_14 * u_xlat16_7.x + u_xlat16_23;
    u_xlat16_3.x = u_xlat16_23 + _DarkDisCt;
    u_xlat16_3.y = u_xlat16_3.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_3.xy = (-vec2(u_xlat16_17)) + u_xlat16_3.xy;
    u_xlat16_24 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_24 = float(1.0) / u_xlat16_24;
    u_xlat16_3.xy = vec2(u_xlat16_24) * u_xlat16_3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_3.y * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_3.y * u_xlat16_3.y;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_10) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.0<_Rim_Switch);
#else
    u_xlatb7 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb7)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_17);
    u_xlat16_23 = u_xlat16_24 * u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) * _EnvColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _EnvColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat16_23 * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_2.x = u_xlat16_9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat11;
ivec2 u_xlati11;
lowp float u_xlat10_14;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat8.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat4 = u_xlat21 * 1.70000005 + (-u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat21 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati11.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat0.x = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_7 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_7.x = u_xlat10_14 + u_xlat10_7;
    u_xlat16_23 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_23 = u_xlat10_14 * u_xlat16_7.x + u_xlat16_23;
    u_xlat16_3.x = u_xlat16_23 + _DarkDisCt;
    u_xlat16_3.y = u_xlat16_3.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_3.xy = (-vec2(u_xlat16_17)) + u_xlat16_3.xy;
    u_xlat16_24 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_24 = float(1.0) / u_xlat16_24;
    u_xlat16_3.xy = vec2(u_xlat16_24) * u_xlat16_3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_3.y * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_3.y * u_xlat16_3.y;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_10) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.0<_Rim_Switch);
#else
    u_xlatb7 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb7)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_17);
    u_xlat16_23 = u_xlat16_24 * u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) * _EnvColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _EnvColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat16_23 * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_2.x = u_xlat16_9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat11;
ivec2 u_xlati11;
lowp float u_xlat10_14;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat8.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat4 = u_xlat21 * 1.70000005 + (-u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat21 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati11.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat0.x = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_7 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_7.x = u_xlat10_14 + u_xlat10_7;
    u_xlat16_23 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_23 = u_xlat10_14 * u_xlat16_7.x + u_xlat16_23;
    u_xlat16_3.x = u_xlat16_23 + _DarkDisCt;
    u_xlat16_3.y = u_xlat16_3.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_3.xy = (-vec2(u_xlat16_17)) + u_xlat16_3.xy;
    u_xlat16_24 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_24 = float(1.0) / u_xlat16_24;
    u_xlat16_3.xy = vec2(u_xlat16_24) * u_xlat16_3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_3.y * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_3.y * u_xlat16_3.y;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_10) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.0<_Rim_Switch);
#else
    u_xlatb7 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb7)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_17);
    u_xlat16_23 = u_xlat16_24 * u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) * _EnvColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _EnvColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat16_23 * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_2.x = u_xlat16_9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
lowp float u_xlat10_14;
bool u_xlatb14;
mediump float u_xlat16_18;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat9.xyz = u_xlat10_2.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_3.x = u_xlat10_2.x * 1.99000001;
    u_xlat22 = u_xlat16_3.x * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat9.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat10_7.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_3.xyz = u_xlat10_7.xyz * _SPCubeMapColor.xyz;
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat7.xyz = u_xlat16_3.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_4.xyz);
    u_xlat7.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat7.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat7.xyz);
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat9.x = u_xlat2.x * 1.70000005 + (-u_xlat22);
    u_xlat2.xz = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat2.xz = u_xlat2.xz + vec2(1.0, 1.0);
    u_xlat2.xz = floor(u_xlat2.xz);
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlati2.xz = ivec2(u_xlat2.xz);
    u_xlat22 = u_xlat9.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat7.xyz : u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat7.x = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_14 = u_xlat10_21 + u_xlat10_14;
    u_xlat16_24 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_24 = u_xlat10_21 * u_xlat16_14 + u_xlat16_24;
    u_xlat16_4.x = u_xlat16_24 + _DarkDisCt;
    u_xlat16_4.y = u_xlat16_4.x + _Rim;
    u_xlat16_18 = (-_Smoothstep) + 1.0;
    u_xlat16_4.xy = (-vec2(u_xlat16_18)) + u_xlat16_4.xy;
    u_xlat16_25 = (-u_xlat16_18) + _Smoothstep;
    u_xlat16_25 = float(1.0) / u_xlat16_25;
    u_xlat16_4.xy = vec2(u_xlat16_25) * u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_4.y * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_4.y * u_xlat16_4.y;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<_Rim_Switch);
#else
    u_xlatb14 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb14)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_24 = u_xlat16_24 + (-u_xlat16_18);
    u_xlat16_24 = u_xlat16_25 * u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_11;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat0.xxx * _RGColor.xyz + (-u_xlat7.xyz);
    u_xlat16_3.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_3.x * _RGRatio;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_3.x = u_xlat16_24 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.x = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_1.w * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x * _Opacity;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
lowp float u_xlat10_14;
bool u_xlatb14;
mediump float u_xlat16_18;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat9.xyz = u_xlat10_2.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_3.x = u_xlat10_2.x * 1.99000001;
    u_xlat22 = u_xlat16_3.x * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat9.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat10_7.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_3.xyz = u_xlat10_7.xyz * _SPCubeMapColor.xyz;
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat7.xyz = u_xlat16_3.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_4.xyz);
    u_xlat7.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat7.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat7.xyz);
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat9.x = u_xlat2.x * 1.70000005 + (-u_xlat22);
    u_xlat2.xz = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat2.xz = u_xlat2.xz + vec2(1.0, 1.0);
    u_xlat2.xz = floor(u_xlat2.xz);
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlati2.xz = ivec2(u_xlat2.xz);
    u_xlat22 = u_xlat9.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat7.xyz : u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat7.x = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_14 = u_xlat10_21 + u_xlat10_14;
    u_xlat16_24 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_24 = u_xlat10_21 * u_xlat16_14 + u_xlat16_24;
    u_xlat16_4.x = u_xlat16_24 + _DarkDisCt;
    u_xlat16_4.y = u_xlat16_4.x + _Rim;
    u_xlat16_18 = (-_Smoothstep) + 1.0;
    u_xlat16_4.xy = (-vec2(u_xlat16_18)) + u_xlat16_4.xy;
    u_xlat16_25 = (-u_xlat16_18) + _Smoothstep;
    u_xlat16_25 = float(1.0) / u_xlat16_25;
    u_xlat16_4.xy = vec2(u_xlat16_25) * u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_4.y * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_4.y * u_xlat16_4.y;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<_Rim_Switch);
#else
    u_xlatb14 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb14)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_24 = u_xlat16_24 + (-u_xlat16_18);
    u_xlat16_24 = u_xlat16_25 * u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_11;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat0.xxx * _RGColor.xyz + (-u_xlat7.xyz);
    u_xlat16_3.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_3.x * _RGRatio;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_3.x = u_xlat16_24 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.x = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_1.w * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x * _Opacity;
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
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
lowp float u_xlat10_14;
bool u_xlatb14;
mediump float u_xlat16_18;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat9.xyz = u_xlat10_2.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_3.x = u_xlat10_2.x * 1.99000001;
    u_xlat22 = u_xlat16_3.x * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat9.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat10_7.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_3.xyz = u_xlat10_7.xyz * _SPCubeMapColor.xyz;
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat7.xyz = u_xlat16_3.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_4.xyz);
    u_xlat7.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat7.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat7.xyz);
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat9.x = u_xlat2.x * 1.70000005 + (-u_xlat22);
    u_xlat2.xz = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat2.xz = u_xlat2.xz + vec2(1.0, 1.0);
    u_xlat2.xz = floor(u_xlat2.xz);
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlati2.xz = ivec2(u_xlat2.xz);
    u_xlat22 = u_xlat9.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat7.xyz : u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat7.x = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_14 = u_xlat10_21 + u_xlat10_14;
    u_xlat16_24 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_24 = u_xlat10_21 * u_xlat16_14 + u_xlat16_24;
    u_xlat16_4.x = u_xlat16_24 + _DarkDisCt;
    u_xlat16_4.y = u_xlat16_4.x + _Rim;
    u_xlat16_18 = (-_Smoothstep) + 1.0;
    u_xlat16_4.xy = (-vec2(u_xlat16_18)) + u_xlat16_4.xy;
    u_xlat16_25 = (-u_xlat16_18) + _Smoothstep;
    u_xlat16_25 = float(1.0) / u_xlat16_25;
    u_xlat16_4.xy = vec2(u_xlat16_25) * u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_4.y * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_4.y * u_xlat16_4.y;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<_Rim_Switch);
#else
    u_xlatb14 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb14)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_24 = u_xlat16_24 + (-u_xlat16_18);
    u_xlat16_24 = u_xlat16_25 * u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_11;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat0.xxx * _RGColor.xyz + (-u_xlat7.xyz);
    u_xlat16_3.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_3.x * _RGRatio;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_3.x = u_xlat16_24 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.x = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_1.w * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x * _Opacity;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
lowp float u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_1.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_1.x = u_xlat10_5 * u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.y = u_xlat16_1.x + _DarkDisCt;
    u_xlat16_1.z = u_xlat16_1.y + _Rim;
    u_xlat16_16 = (-_Smoothstep) + 1.0;
    u_xlat16_1.xyz = (-vec3(u_xlat16_16)) + u_xlat16_1.xyz;
    u_xlat16_2.x = (-u_xlat16_16) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_1.z * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_1.z * u_xlat16_1.z;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_7.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_0.x * _DarkColor.xxyz.y, u_xlat10_0.y * _DarkColor.xxyz.z, u_xlat10_0.z * float(_DarkColor.z));
    u_xlat16_3.xyz = u_xlat10_0.xyz * _RimColor.xyz + (-u_xlat16_7.xyz);
    u_xlat16_0 = u_xlat10_0 * _LightColor;
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0<_Rim_Switch);
#else
    u_xlatb4 = 0.0<_Rim_Switch;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb4)) ? u_xlat16_3.xyz : u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-u_xlat16_7.xyz);
    u_xlat16_11 = u_xlat16_1.y * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_1.y * u_xlat16_1.y;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = u_xlat16_6.xyz * _EnvColor.xyz;
    u_xlat16_4.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = (-u_xlat16_6.xyz) * _EnvColor.xyz + u_xlat16_4.xxx;
    u_xlat16_4.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz;
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
    u_xlat16_1.x = u_xlat16_0.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _Opacity;
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
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
lowp float u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_1.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_1.x = u_xlat10_5 * u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.y = u_xlat16_1.x + _DarkDisCt;
    u_xlat16_1.z = u_xlat16_1.y + _Rim;
    u_xlat16_16 = (-_Smoothstep) + 1.0;
    u_xlat16_1.xyz = (-vec3(u_xlat16_16)) + u_xlat16_1.xyz;
    u_xlat16_2.x = (-u_xlat16_16) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_1.z * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_1.z * u_xlat16_1.z;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_7.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_0.x * _DarkColor.xxyz.y, u_xlat10_0.y * _DarkColor.xxyz.z, u_xlat10_0.z * float(_DarkColor.z));
    u_xlat16_3.xyz = u_xlat10_0.xyz * _RimColor.xyz + (-u_xlat16_7.xyz);
    u_xlat16_0 = u_xlat10_0 * _LightColor;
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0<_Rim_Switch);
#else
    u_xlatb4 = 0.0<_Rim_Switch;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb4)) ? u_xlat16_3.xyz : u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-u_xlat16_7.xyz);
    u_xlat16_11 = u_xlat16_1.y * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_1.y * u_xlat16_1.y;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = u_xlat16_6.xyz * _EnvColor.xyz;
    u_xlat16_4.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = (-u_xlat16_6.xyz) * _EnvColor.xyz + u_xlat16_4.xxx;
    u_xlat16_4.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz;
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
    u_xlat16_1.x = u_xlat16_0.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _Opacity;
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
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
bool u_xlatb4;
lowp float u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_11;
mediump float u_xlat16_16;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_5 + u_xlat10_0.x;
    u_xlat16_1.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_5 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_1.x = u_xlat10_5 * u_xlat16_0.x + u_xlat16_1.x;
    u_xlat16_1.y = u_xlat16_1.x + _DarkDisCt;
    u_xlat16_1.z = u_xlat16_1.y + _Rim;
    u_xlat16_16 = (-_Smoothstep) + 1.0;
    u_xlat16_1.xyz = (-vec3(u_xlat16_16)) + u_xlat16_1.xyz;
    u_xlat16_2.x = (-u_xlat16_16) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_2.xxx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.xyz = min(max(u_xlat16_1.xyz, 0.0), 1.0);
#else
    u_xlat16_1.xyz = clamp(u_xlat16_1.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_1.z * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_1.z * u_xlat16_1.z;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_7.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_7.xyz = vec3(u_xlat10_0.x * _DarkColor.xxyz.y, u_xlat10_0.y * _DarkColor.xxyz.z, u_xlat10_0.z * float(_DarkColor.z));
    u_xlat16_3.xyz = u_xlat10_0.xyz * _RimColor.xyz + (-u_xlat16_7.xyz);
    u_xlat16_0 = u_xlat10_0 * _LightColor;
    u_xlat16_3.xyz = vec3(u_xlat16_11) * u_xlat16_3.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(0.0<_Rim_Switch);
#else
    u_xlatb4 = 0.0<_Rim_Switch;
#endif
    u_xlat16_7.xyz = (bool(u_xlatb4)) ? u_xlat16_3.xyz : u_xlat16_7.xyz;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vs_COLOR0.xyz + (-u_xlat16_7.xyz);
    u_xlat16_11 = u_xlat16_1.y * -2.0 + 3.0;
    u_xlat16_6.x = u_xlat16_1.y * u_xlat16_1.y;
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_11;
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_3.xyz + u_xlat16_7.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = u_xlat16_6.xyz * _EnvColor.xyz;
    u_xlat16_4.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_4.xyz = (-u_xlat16_6.xyz) * _EnvColor.xyz + u_xlat16_4.xxx;
    u_xlat16_4.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_4.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_4.xyz;
    u_xlat16_6.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_6.x;
    u_xlat16_1.x = u_xlat16_0.w * u_xlat16_1.x;
    SV_Target0.w = u_xlat16_1.x * _Opacity;
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
Keywords { "LUMINANCE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat16_2.x * _RGRatio;
    u_xlat10_12 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_18 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_12 = u_xlat10_18 + u_xlat10_12;
    u_xlat16_2.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_18 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_2.x = u_xlat10_18 * u_xlat16_12 + u_xlat16_2.x;
    u_xlat16_2.y = u_xlat16_2.x + _DarkDisCt;
    u_xlat16_2.z = u_xlat16_2.y + _Rim;
    u_xlat16_20 = (-_Smoothstep) + 1.0;
    u_xlat16_2.xyz = (-vec3(u_xlat16_20)) + u_xlat16_2.xyz;
    u_xlat16_3 = (-u_xlat16_20) + _Smoothstep;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_2.z * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_2.z * u_xlat16_2.z;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_9.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_9.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_4.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_9.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_4.xyz = vec3(u_xlat16_14) * u_xlat16_4.xyz + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<_Rim_Switch);
#else
    u_xlatb12 = 0.0<_Rim_Switch;
#endif
    u_xlat16_9.xyz = (bool(u_xlatb12)) ? u_xlat16_4.xyz : u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_9.xyz);
    u_xlat16_14 = u_xlat16_2.y * -2.0 + 3.0;
    u_xlat16_8.x = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_14;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_4.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_SmokeBrightness);
    u_xlat16_8.xyz = u_xlat16_8.xyz * _EnvColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_8.xyz);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw + u_xlat16_8.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_8.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_8.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "LUMINANCE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat16_2.x * _RGRatio;
    u_xlat10_12 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_18 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_12 = u_xlat10_18 + u_xlat10_12;
    u_xlat16_2.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_18 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_2.x = u_xlat10_18 * u_xlat16_12 + u_xlat16_2.x;
    u_xlat16_2.y = u_xlat16_2.x + _DarkDisCt;
    u_xlat16_2.z = u_xlat16_2.y + _Rim;
    u_xlat16_20 = (-_Smoothstep) + 1.0;
    u_xlat16_2.xyz = (-vec3(u_xlat16_20)) + u_xlat16_2.xyz;
    u_xlat16_3 = (-u_xlat16_20) + _Smoothstep;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_2.z * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_2.z * u_xlat16_2.z;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_9.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_9.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_4.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_9.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_4.xyz = vec3(u_xlat16_14) * u_xlat16_4.xyz + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<_Rim_Switch);
#else
    u_xlatb12 = 0.0<_Rim_Switch;
#endif
    u_xlat16_9.xyz = (bool(u_xlatb12)) ? u_xlat16_4.xyz : u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_9.xyz);
    u_xlat16_14 = u_xlat16_2.y * -2.0 + 3.0;
    u_xlat16_8.x = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_14;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_4.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_SmokeBrightness);
    u_xlat16_8.xyz = u_xlat16_8.xyz * _EnvColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_8.xyz);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw + u_xlat16_8.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_8.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_8.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "LUMINANCE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat6;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
bool u_xlatb12;
mediump float u_xlat16_14;
float u_xlat18;
lowp float u_xlat10_18;
mediump float u_xlat16_20;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat18 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * vs_TEXCOORD3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_2.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat16_2.x * _RGRatio;
    u_xlat10_12 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_18 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_12 = u_xlat10_18 + u_xlat10_12;
    u_xlat16_2.x = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_18 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_2.x = u_xlat10_18 * u_xlat16_12 + u_xlat16_2.x;
    u_xlat16_2.y = u_xlat16_2.x + _DarkDisCt;
    u_xlat16_2.z = u_xlat16_2.y + _Rim;
    u_xlat16_20 = (-_Smoothstep) + 1.0;
    u_xlat16_2.xyz = (-vec3(u_xlat16_20)) + u_xlat16_2.xyz;
    u_xlat16_3 = (-u_xlat16_20) + _Smoothstep;
    u_xlat16_3 = float(1.0) / u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_3);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.xyz = min(max(u_xlat16_2.xyz, 0.0), 1.0);
#else
    u_xlat16_2.xyz = clamp(u_xlat16_2.xyz, 0.0, 1.0);
#endif
    u_xlat16_9.x = u_xlat16_2.z * -2.0 + 3.0;
    u_xlat16_14 = u_xlat16_2.z * u_xlat16_2.z;
    u_xlat16_14 = u_xlat16_14 * u_xlat16_9.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_9.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_4.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_9.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_4.xyz = vec3(u_xlat16_14) * u_xlat16_4.xyz + u_xlat16_9.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.0<_Rim_Switch);
#else
    u_xlatb12 = 0.0<_Rim_Switch;
#endif
    u_xlat16_9.xyz = (bool(u_xlatb12)) ? u_xlat16_4.xyz : u_xlat16_9.xyz;
    u_xlat16_4.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_9.xyz);
    u_xlat16_14 = u_xlat16_2.y * -2.0 + 3.0;
    u_xlat16_8.x = u_xlat16_2.y * u_xlat16_2.y;
    u_xlat16_8.x = u_xlat16_8.x * u_xlat16_14;
    u_xlat16_8.xyz = u_xlat16_8.xxx * u_xlat16_4.xyz + u_xlat16_9.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(_SmokeBrightness);
    u_xlat16_8.xyz = u_xlat16_8.xyz * _EnvColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_8.xyz);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xzw + u_xlat16_8.xyz;
    u_xlat18 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(u_xlat18);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat5.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_8.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_8.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat11;
ivec2 u_xlati11;
lowp float u_xlat10_14;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat8.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat4.x = u_xlat21 * 1.70000005 + (-u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat21 = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati11.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat0.x = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_7 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_7.x = u_xlat10_14 + u_xlat10_7;
    u_xlat16_23 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_23 = u_xlat10_14 * u_xlat16_7.x + u_xlat16_23;
    u_xlat16_3.x = u_xlat16_23 + _DarkDisCt;
    u_xlat16_3.y = u_xlat16_3.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_3.xy = (-vec2(u_xlat16_17)) + u_xlat16_3.xy;
    u_xlat16_24 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_24 = float(1.0) / u_xlat16_24;
    u_xlat16_3.xy = vec2(u_xlat16_24) * u_xlat16_3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_3.y * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_3.y * u_xlat16_3.y;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_10) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.0<_Rim_Switch);
#else
    u_xlatb7 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb7)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_17);
    u_xlat16_23 = u_xlat16_24 * u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) * _EnvColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _EnvColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat4.xyz = (-u_xlat0.xyz) + vec3(u_xlat21);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat4.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat16_23 * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_2.x = u_xlat16_9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat11;
ivec2 u_xlati11;
lowp float u_xlat10_14;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat8.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat4.x = u_xlat21 * 1.70000005 + (-u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat21 = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati11.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat0.x = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_7 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_7.x = u_xlat10_14 + u_xlat10_7;
    u_xlat16_23 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_23 = u_xlat10_14 * u_xlat16_7.x + u_xlat16_23;
    u_xlat16_3.x = u_xlat16_23 + _DarkDisCt;
    u_xlat16_3.y = u_xlat16_3.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_3.xy = (-vec2(u_xlat16_17)) + u_xlat16_3.xy;
    u_xlat16_24 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_24 = float(1.0) / u_xlat16_24;
    u_xlat16_3.xy = vec2(u_xlat16_24) * u_xlat16_3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_3.y * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_3.y * u_xlat16_3.y;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_10) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.0<_Rim_Switch);
#else
    u_xlatb7 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb7)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_17);
    u_xlat16_23 = u_xlat16_24 * u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) * _EnvColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _EnvColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat4.xyz = (-u_xlat0.xyz) + vec3(u_xlat21);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat4.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat16_23 * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_2.x = u_xlat16_9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "LUMINANCE" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
lowp float u_xlat10_7;
bool u_xlatb7;
vec3 u_xlat8;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
vec2 u_xlat11;
ivec2 u_xlati11;
lowp float u_xlat10_14;
mediump float u_xlat16_17;
float u_xlat21;
mediump float u_xlat16_23;
mediump float u_xlat16_24;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat8.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat8.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat8.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat0.xyz = u_xlat8.xyz * (-vec3(u_xlat21)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat21 = _SPNoiseScaler * _SPTransition;
    u_xlat4.x = u_xlat21 * 1.70000005 + (-u_xlat1.x);
    u_xlat11.xy = vec2(u_xlat21) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat11.xy = u_xlat11.xy + vec2(1.0, 1.0);
    u_xlat11.xy = floor(u_xlat11.xy);
    u_xlat11.xy = max(u_xlat11.xy, vec2(0.0, 0.0));
    u_xlati11.xy = ivec2(u_xlat11.xy);
    u_xlat21 = u_xlat4.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat21) * u_xlat8.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati11.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati11.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat0.x = (u_xlati11.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_7 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_7.x = u_xlat10_14 + u_xlat10_7;
    u_xlat16_23 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_23 = u_xlat10_14 * u_xlat16_7.x + u_xlat16_23;
    u_xlat16_3.x = u_xlat16_23 + _DarkDisCt;
    u_xlat16_3.y = u_xlat16_3.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_3.xy = (-vec2(u_xlat16_17)) + u_xlat16_3.xy;
    u_xlat16_24 = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_24 = float(1.0) / u_xlat16_24;
    u_xlat16_3.xy = vec2(u_xlat16_24) * u_xlat16_3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xy = min(max(u_xlat16_3.xy, 0.0), 1.0);
#else
    u_xlat16_3.xy = clamp(u_xlat16_3.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_3.y * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_3.y * u_xlat16_3.y;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_10) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(0.0<_Rim_Switch);
#else
    u_xlatb7 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb7)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_23 = u_xlat16_23 + (-u_xlat16_17);
    u_xlat16_23 = u_xlat16_24 * u_xlat16_23;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
#else
    u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_3.x * -2.0 + 3.0;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_10;
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_7.xyz = (-u_xlat16_3.xyz) * _EnvColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _EnvColor.xyz;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat16_7.xyz + u_xlat16_2.xyz;
    u_xlat21 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat4.xyz = (-u_xlat0.xyz) + vec3(u_xlat21);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat4.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_2.x = u_xlat16_23 * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_23 * u_xlat16_23;
    u_xlat16_2.x = u_xlat16_9 * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_1.w * u_xlat16_2.x;
    SV_Target0.w = u_xlat16_2.x * _Opacity;
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
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
lowp float u_xlat10_14;
bool u_xlatb14;
mediump float u_xlat16_18;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat9.xyz = u_xlat10_2.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_3.x = u_xlat10_2.x * 1.99000001;
    u_xlat22 = u_xlat16_3.x * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat9.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat10_7.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_3.xyz = u_xlat10_7.xyz * _SPCubeMapColor.xyz;
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat7.xyz = u_xlat16_3.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_4.xyz);
    u_xlat7.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat7.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat7.xyz);
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat9.x = u_xlat2.x * 1.70000005 + (-u_xlat22);
    u_xlat2.xz = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat2.xz = u_xlat2.xz + vec2(1.0, 1.0);
    u_xlat2.xz = floor(u_xlat2.xz);
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlati2.xz = ivec2(u_xlat2.xz);
    u_xlat22 = u_xlat9.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat7.xyz : u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat7.x = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_14 = u_xlat10_21 + u_xlat10_14;
    u_xlat16_24 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_24 = u_xlat10_21 * u_xlat16_14 + u_xlat16_24;
    u_xlat16_4.x = u_xlat16_24 + _DarkDisCt;
    u_xlat16_4.y = u_xlat16_4.x + _Rim;
    u_xlat16_18 = (-_Smoothstep) + 1.0;
    u_xlat16_4.xy = (-vec2(u_xlat16_18)) + u_xlat16_4.xy;
    u_xlat16_25 = (-u_xlat16_18) + _Smoothstep;
    u_xlat16_25 = float(1.0) / u_xlat16_25;
    u_xlat16_4.xy = vec2(u_xlat16_25) * u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_4.y * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_4.y * u_xlat16_4.y;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<_Rim_Switch);
#else
    u_xlatb14 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb14)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_24 = u_xlat16_24 + (-u_xlat16_18);
    u_xlat16_24 = u_xlat16_25 * u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_11;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat0.xxx * _RGColor.xyz + (-u_xlat7.xyz);
    u_xlat16_3.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_3.x * _RGRatio;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    u_xlat21 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(u_xlat21);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_3.x = u_xlat16_24 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.x = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_1.w * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x * _Opacity;
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
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
lowp float u_xlat10_14;
bool u_xlatb14;
mediump float u_xlat16_18;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat9.xyz = u_xlat10_2.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_3.x = u_xlat10_2.x * 1.99000001;
    u_xlat22 = u_xlat16_3.x * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat9.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat10_7.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_3.xyz = u_xlat10_7.xyz * _SPCubeMapColor.xyz;
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat7.xyz = u_xlat16_3.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_4.xyz);
    u_xlat7.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat7.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat7.xyz);
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat9.x = u_xlat2.x * 1.70000005 + (-u_xlat22);
    u_xlat2.xz = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat2.xz = u_xlat2.xz + vec2(1.0, 1.0);
    u_xlat2.xz = floor(u_xlat2.xz);
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlati2.xz = ivec2(u_xlat2.xz);
    u_xlat22 = u_xlat9.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat7.xyz : u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat7.x = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_14 = u_xlat10_21 + u_xlat10_14;
    u_xlat16_24 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_24 = u_xlat10_21 * u_xlat16_14 + u_xlat16_24;
    u_xlat16_4.x = u_xlat16_24 + _DarkDisCt;
    u_xlat16_4.y = u_xlat16_4.x + _Rim;
    u_xlat16_18 = (-_Smoothstep) + 1.0;
    u_xlat16_4.xy = (-vec2(u_xlat16_18)) + u_xlat16_4.xy;
    u_xlat16_25 = (-u_xlat16_18) + _Smoothstep;
    u_xlat16_25 = float(1.0) / u_xlat16_25;
    u_xlat16_4.xy = vec2(u_xlat16_25) * u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_4.y * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_4.y * u_xlat16_4.y;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<_Rim_Switch);
#else
    u_xlatb14 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb14)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_24 = u_xlat16_24 + (-u_xlat16_18);
    u_xlat16_24 = u_xlat16_25 * u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_11;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat0.xxx * _RGColor.xyz + (-u_xlat7.xyz);
    u_xlat16_3.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_3.x * _RGRatio;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    u_xlat21 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(u_xlat21);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_3.x = u_xlat16_24 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.x = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_1.w * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x * _Opacity;
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
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisTexture_ST;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec3 in_NORMAL0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
vec2 u_xlat4;
vec2 u_xlat5;
float u_xlat6;
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
    vs_COLOR0 = in_COLOR0;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy;
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    vs_TEXCOORD3.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat2 = u_xlat0.w + u_xlat0.y;
    u_xlat6 = u_xlat0.x * in_POSITION0.x;
    u_xlat5.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat5.y = u_xlat6 * 0.25 + u_xlat2;
    vs_TEXCOORD4.zw = u_xlat5.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	float _Rim_Switch;
uniform 	mediump vec4 _LightColor;
uniform 	mediump vec4 _EnvColor;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _DisNoise;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _DarkColor;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _DarkDisCt;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform 	mediump float _Opacity;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
vec3 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
ivec3 u_xlati2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
vec3 u_xlat7;
lowp vec3 u_xlat10_7;
vec3 u_xlat9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
mediump float u_xlat16_14;
lowp float u_xlat10_14;
bool u_xlatb14;
mediump float u_xlat16_18;
float u_xlat21;
lowp float u_xlat10_21;
float u_xlat22;
mediump float u_xlat16_24;
mediump float u_xlat16_25;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat1.xyz = u_xlat0.xyz * vec3(u_xlat21) + (-_WorldSpaceCameraPos.xyz);
    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat10_2.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat9.xyz = u_xlat10_2.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_3.x = u_xlat10_2.x * 1.99000001;
    u_xlat22 = u_xlat16_3.x * _SPNoiseScaler + -1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat21) + u_xlat9.xyz;
    u_xlat1.xyz = u_xlat1.xyz + _SPCubeMapOffset.xyz;
    u_xlat21 = dot(vs_TEXCOORD3.xyz, vs_TEXCOORD3.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * vs_TEXCOORD3.xyz;
    u_xlat21 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat21 = u_xlat21 + u_xlat21;
    u_xlat1.xyz = u_xlat2.xyz * (-vec3(u_xlat21)) + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat10_7.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_3.xyz = u_xlat10_7.xyz * _SPCubeMapColor.xyz;
    u_xlat10_7.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_4.xyz = u_xlat10_7.xyz * _SPOldColor.xyz;
    u_xlat7.xyz = u_xlat16_3.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_4.xyz);
    u_xlat7.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat7.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat7.xyz);
    u_xlat2.x = _SPNoiseScaler * _SPTransition;
    u_xlat9.x = u_xlat2.x * 1.70000005 + (-u_xlat22);
    u_xlat2.xz = u_xlat2.xx * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat2.xz = u_xlat2.xz + vec2(1.0, 1.0);
    u_xlat2.xz = floor(u_xlat2.xz);
    u_xlat2.xz = max(u_xlat2.xz, vec2(0.0, 0.0));
    u_xlati2.xz = ivec2(u_xlat2.xz);
    u_xlat22 = u_xlat9.x * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat22 = min(max(u_xlat22, 0.0), 1.0);
#else
    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat22) * u_xlat1.xyz + u_xlat7.xyz;
    u_xlat16_3.xyz = (u_xlati2.z != 0) ? u_xlat7.xyz : u_xlat1.xyz;
    u_xlat16_3.xyz = (u_xlati2.x != 0) ? u_xlat16_3.xyz : u_xlat7.xyz;
    u_xlat7.x = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat10_14 = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_14 = u_xlat10_21 + u_xlat10_14;
    u_xlat16_24 = vs_COLOR0.w * 3.0 + _DisNoise;
    u_xlat10_21 = texture(_DisTexture, vs_TEXCOORD1.xy).z;
    u_xlat16_24 = u_xlat10_21 * u_xlat16_14 + u_xlat16_24;
    u_xlat16_4.x = u_xlat16_24 + _DarkDisCt;
    u_xlat16_4.y = u_xlat16_4.x + _Rim;
    u_xlat16_18 = (-_Smoothstep) + 1.0;
    u_xlat16_4.xy = (-vec2(u_xlat16_18)) + u_xlat16_4.xy;
    u_xlat16_25 = (-u_xlat16_18) + _Smoothstep;
    u_xlat16_25 = float(1.0) / u_xlat16_25;
    u_xlat16_4.xy = vec2(u_xlat16_25) * u_xlat16_4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xy = min(max(u_xlat16_4.xy, 0.0), 1.0);
#else
    u_xlat16_4.xy = clamp(u_xlat16_4.xy, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_4.y * -2.0 + 3.0;
    u_xlat16_11 = u_xlat16_4.y * u_xlat16_4.y;
    u_xlat16_11 = u_xlat16_11 * u_xlat16_5.x;
    u_xlat10_1 = texture(_MainSmokeTexture, vs_TEXCOORD1.xy);
    u_xlat16_5.xyz = vec3(u_xlat10_1.x * _DarkColor.xxyz.y, u_xlat10_1.y * _DarkColor.xxyz.z, u_xlat10_1.z * float(_DarkColor.z));
    u_xlat16_6.xyz = u_xlat10_1.xyz * _RimColor.xyz + (-u_xlat16_5.xyz);
    u_xlat16_1 = u_xlat10_1 * _LightColor;
    u_xlat16_6.xyz = vec3(u_xlat16_11) * u_xlat16_6.xyz + u_xlat16_5.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(0.0<_Rim_Switch);
#else
    u_xlatb14 = 0.0<_Rim_Switch;
#endif
    u_xlat16_5.xyz = (bool(u_xlatb14)) ? u_xlat16_6.xyz : u_xlat16_5.xyz;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz + (-u_xlat16_5.xyz);
    u_xlat16_24 = u_xlat16_24 + (-u_xlat16_18);
    u_xlat16_24 = u_xlat16_25 * u_xlat16_24;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_24 = min(max(u_xlat16_24, 0.0), 1.0);
#else
    u_xlat16_24 = clamp(u_xlat16_24, 0.0, 1.0);
#endif
    u_xlat16_11 = u_xlat16_4.x * -2.0 + 3.0;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_4.x;
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_11;
    u_xlat16_4.xyz = u_xlat16_4.xxx * u_xlat16_6.xyz + u_xlat16_5.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.xyz = (-u_xlat16_4.xyz) * _EnvColor.xyz + u_xlat16_3.xyz;
    u_xlat16_3.xyz = u_xlat16_4.xyz * _EnvColor.xyz;
    u_xlat7.xyz = u_xlat7.xxx * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat2.xyz = u_xlat0.xxx * _RGColor.xyz + (-u_xlat7.xyz);
    u_xlat16_3.x = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat16_3.x * _RGRatio;
    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz + u_xlat7.xyz;
    u_xlat21 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(u_xlat21);
    u_xlat0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat2.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat16_3.x = u_xlat16_24 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_24 * u_xlat16_24;
    u_xlat16_3.x = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_3.x = u_xlat16_1.w * u_xlat16_3.x;
    SV_Target0.w = u_xlat16_3.x * _Opacity;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
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
Keywords { "LUMINANCE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "SPECIAL_STATE" "RIM_GLOW" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.CharacterShaderEditorBase"
}