//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple Transparent" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
_SpecMulti ("Specular Multiply", Float) = 1
_Shininess ("Shininess", Range(0.1, 100)) = 2
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_Ramp ("Toon Ramp (RGB)", 2D) = "white" { }
_SpecRamp ("Specular Ramp (RGB)", 2D) = "black" { }
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
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
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  GpuProgramID 20185
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat4.xy = vec2(u_xlat18) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati18 = int(u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13) + u_xlat3.xyz;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_1.w = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat4.xy = vec2(u_xlat18) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati18 = int(u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13) + u_xlat3.xyz;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_1.w = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
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
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat18 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat4.xy = vec2(u_xlat18) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati18 = int(u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13) + u_xlat3.xyz;
    u_xlat13 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_1.w = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.w = min(max(u_xlat16_1.w, 0.0), 1.0);
#else
    u_xlat16_1.w = clamp(u_xlat16_1.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_1;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat4.xy = vec2(u_xlat18) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati18 = int(u_xlat16_5);
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat13) + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _Shininess;
    u_xlat13 = exp2(u_xlat13);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? vec2(u_xlat13) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_15;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    SV_Target0.w = u_xlat16_15;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat4.xy = vec2(u_xlat18) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati18 = int(u_xlat16_5);
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat13) + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _Shininess;
    u_xlat13 = exp2(u_xlat13);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? vec2(u_xlat13) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_15;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    SV_Target0.w = u_xlat16_15;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat4.xy = vec2(u_xlat18) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati18 = int(u_xlat16_5);
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat13 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat13) + u_xlat2.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _Shininess;
    u_xlat13 = exp2(u_xlat13);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? vec2(u_xlat13) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
bvec2 u_xlatb8;
mediump float u_xlat16_15;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    SV_Target0.w = u_xlat16_15;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat11;
int u_xlati11;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * _WorldSpaceLightPos0.xyz;
    u_xlat11 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat3.xy = vec2(u_xlat11) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
    u_xlat16_4 = u_xlat3.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati11 = int(u_xlat16_4);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat17 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat17);
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati11) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_4 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat16_4 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(u_xlat5) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = u_xlat16_18;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat11;
int u_xlati11;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * _WorldSpaceLightPos0.xyz;
    u_xlat11 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat3.xy = vec2(u_xlat11) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
    u_xlat16_4 = u_xlat3.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati11 = int(u_xlat16_4);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat17 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat17);
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati11) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_4 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat16_4 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(u_xlat5) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = u_xlat16_18;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat11;
int u_xlati11;
float u_xlat15;
float u_xlat17;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    u_xlat0.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat2.xyz = vec3(u_xlat15) * u_xlat2.xyz;
    u_xlat15 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * _WorldSpaceLightPos0.xyz;
    u_xlat11 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat3.xy = vec2(u_xlat11) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
    u_xlat16_4 = u_xlat3.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati11 = int(u_xlat16_4);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat17 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat17);
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat15) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati11) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_4;
float u_xlat5;
bvec2 u_xlatb10;
float u_xlat15;
mediump float u_xlat16_18;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb10.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb10.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb10.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_18 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_18 = min(max(u_xlat16_18, 0.0), 1.0);
#else
    u_xlat16_18 = clamp(u_xlat16_18, 0.0, 1.0);
#endif
    u_xlat0.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD6.xyz;
    u_xlat15 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat1.xyz = vec3(u_xlat15) * vs_TEXCOORD5.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
    u_xlat0.x = (-u_xlat0.x) + 1.00100005;
    u_xlat0.x = max(u_xlat0.x, 0.00100000005);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGShininess;
    u_xlat0.x = exp2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _RGScale + _RGBias;
    u_xlat16_4 = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4 = min(max(u_xlat16_4, 0.0), 1.0);
#else
    u_xlat16_4 = clamp(u_xlat16_4, 0.0, 1.0);
#endif
    u_xlat5 = u_xlat16_4 * _RGRatio;
    u_xlat0.xzw = u_xlat0.xxx * _RGColor.xyz + (-u_xlat16_3.xyz);
    SV_Target0.xyz = vec3(u_xlat5) * u_xlat0.xzw + u_xlat16_3.xyz;
    SV_Target0.w = u_xlat16_18;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat13;
int u_xlati13;
float u_xlat18;
float u_xlat20;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati13 = int(u_xlat16_4);
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Shininess;
    u_xlat18 = exp2(u_xlat18);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? vec2(u_xlat18) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
bvec2 u_xlatb8;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + 1.00100005;
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _RGShininess;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _RGScale + _RGBias;
    u_xlat16_3.x = u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_3.x * _RGRatio;
    u_xlat5.xyz = vec3(u_xlat12) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat16_15;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat13;
int u_xlati13;
float u_xlat18;
float u_xlat20;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati13 = int(u_xlat16_4);
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Shininess;
    u_xlat18 = exp2(u_xlat18);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? vec2(u_xlat18) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
bvec2 u_xlatb8;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + 1.00100005;
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _RGShininess;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _RGScale + _RGBias;
    u_xlat16_3.x = u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_3.x * _RGRatio;
    u_xlat5.xyz = vec3(u_xlat12) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat16_15;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
float u_xlat13;
int u_xlati13;
float u_xlat18;
float u_xlat20;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat18 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati13 = int(u_xlat16_4);
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat18) + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat5.xyz;
    u_xlat18 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat18 = max(u_xlat18, 0.0);
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Shininess;
    u_xlat18 = exp2(u_xlat18);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? vec2(u_xlat18) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	mediump vec4 _RGColor;
uniform 	float _RGShininess;
uniform 	float _RGScale;
uniform 	float _RGBias;
uniform 	float _RGRatio;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat5;
bvec2 u_xlatb8;
float u_xlat12;
mediump float u_xlat16_15;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb8.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb8.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb8.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_15 = u_xlat0.w * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_15 = min(max(u_xlat16_15, 0.0), 1.0);
#else
    u_xlat16_15 = clamp(u_xlat16_15, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat12 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD6.xyz;
    u_xlat12 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * vs_TEXCOORD5.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat12 = (-u_xlat12) + 1.00100005;
    u_xlat12 = max(u_xlat12, 0.00100000005);
    u_xlat12 = min(u_xlat12, 1.0);
    u_xlat12 = log2(u_xlat12);
    u_xlat12 = u_xlat12 * _RGShininess;
    u_xlat12 = exp2(u_xlat12);
    u_xlat12 = u_xlat12 * _RGScale + _RGBias;
    u_xlat16_3.x = u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_3.x * _RGRatio;
    u_xlat5.xyz = vec3(u_xlat12) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat5.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat16_15;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat13;
int u_xlati13;
vec2 u_xlat14;
float u_xlat18;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat4.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati13 = int(u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat6 = u_xlat0.w + u_xlat0.y;
    u_xlat18 = u_xlat0.x * in_POSITION0.x;
    u_xlat14.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat14.y = u_xlat18 * 0.25 + u_xlat6;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
ivec2 u_xlati5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat22;
bvec2 u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat0.w * vs_COLOR0.w;
    u_xlat11 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD6.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat10_6 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_7.w = u_xlat10_6.w * _SPOpaqueness;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat22 = u_xlat10_8.x * _SPNoiseScaler;
    u_xlat22 = u_xlat22 * 1.99000001 + -1.0;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + (-_WorldSpaceCameraPos.xyz);
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat8.xyz;
    u_xlat5.xyz = u_xlat5.xyz + _SPCubeMapOffset.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat11 = u_xlat11 + u_xlat11;
    u_xlat2.xyz = u_xlat2.xyz * (-vec3(u_xlat11)) + u_xlat5.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_9.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_9.xyz;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat11 = u_xlat11 * 1.70000005 + (-u_xlat22);
    u_xlat11 = u_xlat11 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat6.xyz = vec3(u_xlat11) * u_xlat6.xyz + u_xlat2.xyz;
    u_xlat16_9.xyz = (u_xlati5.y != 0) ? u_xlat2.xyz : u_xlat6.xyz;
    u_xlat11 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati5.x != 0) ? u_xlat16_9.xyz : u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat16_4.xyz);
    u_xlat2.w = (-u_xlat0.x);
    u_xlat2 = u_xlat2 + u_xlat16_7;
    u_xlat2 = vec4(u_xlat11) * u_xlat2;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat10_1.xyz + u_xlat2.xyz;
    u_xlat16_3.x = u_xlat0.w * vs_COLOR0.w + u_xlat2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat13;
int u_xlati13;
vec2 u_xlat14;
float u_xlat18;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat4.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati13 = int(u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat6 = u_xlat0.w + u_xlat0.y;
    u_xlat18 = u_xlat0.x * in_POSITION0.x;
    u_xlat14.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat14.y = u_xlat18 * 0.25 + u_xlat6;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
ivec2 u_xlati5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat22;
bvec2 u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat0.w * vs_COLOR0.w;
    u_xlat11 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD6.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat10_6 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_7.w = u_xlat10_6.w * _SPOpaqueness;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat22 = u_xlat10_8.x * _SPNoiseScaler;
    u_xlat22 = u_xlat22 * 1.99000001 + -1.0;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + (-_WorldSpaceCameraPos.xyz);
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat8.xyz;
    u_xlat5.xyz = u_xlat5.xyz + _SPCubeMapOffset.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat11 = u_xlat11 + u_xlat11;
    u_xlat2.xyz = u_xlat2.xyz * (-vec3(u_xlat11)) + u_xlat5.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_9.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_9.xyz;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat11 = u_xlat11 * 1.70000005 + (-u_xlat22);
    u_xlat11 = u_xlat11 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat6.xyz = vec3(u_xlat11) * u_xlat6.xyz + u_xlat2.xyz;
    u_xlat16_9.xyz = (u_xlati5.y != 0) ? u_xlat2.xyz : u_xlat6.xyz;
    u_xlat11 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati5.x != 0) ? u_xlat16_9.xyz : u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat16_4.xyz);
    u_xlat2.w = (-u_xlat0.x);
    u_xlat2 = u_xlat2 + u_xlat16_7;
    u_xlat2 = vec4(u_xlat11) * u_xlat2;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat10_1.xyz + u_xlat2.xyz;
    u_xlat16_3.x = u_xlat0.w * vs_COLOR0.w + u_xlat2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat13;
int u_xlati13;
vec2 u_xlat14;
float u_xlat18;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat13 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat4.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati13 = int(u_xlat16_5);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat6 = u_xlat0.w + u_xlat0.y;
    u_xlat18 = u_xlat0.x * in_POSITION0.x;
    u_xlat14.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat14.y = u_xlat18 * 0.25 + u_xlat6;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
ivec2 u_xlati5;
vec3 u_xlat6;
lowp vec4 u_xlat10_6;
mediump vec4 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
float u_xlat22;
bvec2 u_xlatb22;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat0.w * vs_COLOR0.w;
    u_xlat11 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD6.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat10_6 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_7.w = u_xlat10_6.w * _SPOpaqueness;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat22 = u_xlat10_8.x * _SPNoiseScaler;
    u_xlat22 = u_xlat22 * 1.99000001 + -1.0;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + (-_WorldSpaceCameraPos.xyz);
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat8.xyz;
    u_xlat5.xyz = u_xlat5.xyz + _SPCubeMapOffset.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat11 = u_xlat11 + u_xlat11;
    u_xlat2.xyz = u_xlat2.xyz * (-vec3(u_xlat11)) + u_xlat5.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_9.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_9.xyz;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat11 = u_xlat11 * 1.70000005 + (-u_xlat22);
    u_xlat11 = u_xlat11 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat6.xyz = vec3(u_xlat11) * u_xlat6.xyz + u_xlat2.xyz;
    u_xlat16_9.xyz = (u_xlati5.y != 0) ? u_xlat2.xyz : u_xlat6.xyz;
    u_xlat11 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati5.x != 0) ? u_xlat16_9.xyz : u_xlat2.xyz;
    u_xlat2.xyz = (-u_xlat16_4.xyz);
    u_xlat2.w = (-u_xlat0.x);
    u_xlat2 = u_xlat2 + u_xlat16_7;
    u_xlat2 = vec4(u_xlat11) * u_xlat2;
    SV_Target0.xyz = u_xlat16_3.xyz * u_xlat10_1.xyz + u_xlat2.xyz;
    u_xlat16_3.x = u_xlat0.w * vs_COLOR0.w + u_xlat2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat13;
int u_xlati13;
vec2 u_xlat14;
float u_xlat18;
float u_xlat20;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat4.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati13 = int(u_xlat16_5);
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Shininess;
    u_xlat2.x = exp2(u_xlat2.x);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? u_xlat2.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat13 = u_xlat2.w + u_xlat2.y;
    u_xlat8 = u_xlat2.x * in_POSITION0.x;
    u_xlat14.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat14.y = u_xlat8 * 0.25 + u_xlat13;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec2 u_xlati2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb16;
float u_xlat25;
float u_xlat26;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb16.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb16.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb16.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat10_3 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_4.w = u_xlat10_3.w * _SPOpaqueness;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat26 = u_xlat10_5.x * _SPNoiseScaler;
    u_xlat26 = u_xlat26 * 1.99000001 + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat25)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat25 = _SPNoiseScaler * _SPTransition;
    u_xlat2.xy = vec2(u_xlat25) * vec2(1.70000005, 1.5) + (-vec2(u_xlat26));
    u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
    u_xlati2.xy = ivec2(u_xlat2.xy);
    u_xlat25 = u_xlat25 * 1.70000005 + (-u_xlat26);
    u_xlat25 = u_xlat25 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati2.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat25 = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_4.xyz = (u_xlati2.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat2 = (-u_xlat0) + u_xlat16_4;
    u_xlat0 = vec4(u_xlat25) * u_xlat2 + u_xlat0;
    u_xlat16_4.x = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_4.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat13;
int u_xlati13;
vec2 u_xlat14;
float u_xlat18;
float u_xlat20;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat4.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati13 = int(u_xlat16_5);
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Shininess;
    u_xlat2.x = exp2(u_xlat2.x);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? u_xlat2.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat13 = u_xlat2.w + u_xlat2.y;
    u_xlat8 = u_xlat2.x * in_POSITION0.x;
    u_xlat14.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat14.y = u_xlat8 * 0.25 + u_xlat13;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec2 u_xlati2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb16;
float u_xlat25;
float u_xlat26;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb16.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb16.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb16.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat10_3 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_4.w = u_xlat10_3.w * _SPOpaqueness;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat26 = u_xlat10_5.x * _SPNoiseScaler;
    u_xlat26 = u_xlat26 * 1.99000001 + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat25)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat25 = _SPNoiseScaler * _SPTransition;
    u_xlat2.xy = vec2(u_xlat25) * vec2(1.70000005, 1.5) + (-vec2(u_xlat26));
    u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
    u_xlati2.xy = ivec2(u_xlat2.xy);
    u_xlat25 = u_xlat25 * 1.70000005 + (-u_xlat26);
    u_xlat25 = u_xlat25 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati2.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat25 = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_4.xyz = (u_xlati2.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat2 = (-u_xlat0) + u_xlat16_4;
    u_xlat0 = vec4(u_xlat25) * u_xlat2 + u_xlat0;
    u_xlat16_4.x = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_4.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat8;
float u_xlat13;
int u_xlati13;
vec2 u_xlat14;
float u_xlat18;
float u_xlat20;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat13 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat4.xy = vec2(u_xlat13) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat4.xy;
    u_xlat16_5 = u_xlat4.y + 0.5;
    u_xlat16_5 = floor(u_xlat16_5);
    u_xlat16_5 = max(u_xlat16_5, 0.0);
    u_xlati13 = int(u_xlat16_5);
    u_xlat4.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = u_xlat4.xyz * vec3(u_xlat20) + u_xlat2.xyz;
    u_xlat20 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat2.xyz = vec3(u_xlat20) * u_xlat2.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.x = max(u_xlat2.x, 0.0);
    u_xlat2.x = log2(u_xlat2.x);
    u_xlat2.x = u_xlat2.x * _Shininess;
    u_xlat2.x = exp2(u_xlat2.x);
    vs_TEXCOORD2.xy = (int(u_xlati13) != 0) ? u_xlat2.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat13 = u_xlat2.w + u_xlat2.y;
    u_xlat8 = u_xlat2.x * in_POSITION0.x;
    u_xlat14.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat14.y = u_xlat8 * 0.25 + u_xlat13;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
ivec2 u_xlati2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
bvec2 u_xlatb16;
float u_xlat25;
float u_xlat26;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb16.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb16.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb16.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat10_3 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_4.w = u_xlat10_3.w * _SPOpaqueness;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat26 = u_xlat10_5.x * _SPNoiseScaler;
    u_xlat26 = u_xlat26 * 1.99000001 + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + (-_WorldSpaceCameraPos.xyz);
    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat25) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat25 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat25 = u_xlat25 + u_xlat25;
    u_xlat1.xyz = u_xlat1.xyz * (-vec3(u_xlat25)) + u_xlat2.xyz;
    u_xlat10_1.xyz = texture(_SPCubeMap, u_xlat1.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_1.xyz * _SPCubeMapColor.xyz;
    u_xlat1.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat1.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat1.xyz + u_xlat16_6.xyz;
    u_xlat25 = _SPNoiseScaler * _SPTransition;
    u_xlat2.xy = vec2(u_xlat25) * vec2(1.70000005, 1.5) + (-vec2(u_xlat26));
    u_xlat2.xy = u_xlat2.xy + vec2(1.0, 1.0);
    u_xlat2.xy = floor(u_xlat2.xy);
    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
    u_xlati2.xy = ivec2(u_xlat2.xy);
    u_xlat25 = u_xlat25 * 1.70000005 + (-u_xlat26);
    u_xlat25 = u_xlat25 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat25 = min(max(u_xlat25, 0.0), 1.0);
#else
    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat1.xyz);
    u_xlat5.xyz = vec3(u_xlat25) * u_xlat5.xyz + u_xlat1.xyz;
    u_xlat16_6.xyz = (u_xlati2.y != 0) ? u_xlat1.xyz : u_xlat5.xyz;
    u_xlat25 = (u_xlati2.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_4.xyz = (u_xlati2.x != 0) ? u_xlat16_6.xyz : u_xlat1.xyz;
    u_xlat2 = (-u_xlat0) + u_xlat16_4;
    u_xlat0 = vec4(u_xlat25) * u_xlat2 + u_xlat0;
    u_xlat16_4.x = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = u_xlat16_4.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
float u_xlat17;
int u_xlati17;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    u_xlat11 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat3.xyz = vec3(u_xlat11) * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat3.xy = vec2(u_xlat17) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
    u_xlat16_4 = u_xlat3.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati17 = int(u_xlat16_4);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat11) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati17) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat12.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD3.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
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
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec2 u_xlat6;
lowp vec4 u_xlat10_6;
ivec2 u_xlati6;
mediump vec4 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat12;
mediump float u_xlat16_14;
float u_xlat22;
bvec2 u_xlatb22;
float u_xlat33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat0.w * vs_COLOR0.w;
    u_xlat11 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD6.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat10_6 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_7.w = u_xlat10_6.w * _SPOpaqueness;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat22 = u_xlat10_8.x * _SPNoiseScaler;
    u_xlat22 = u_xlat22 * 1.99000001 + -1.0;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + (-_WorldSpaceCameraPos.xyz);
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat8.xyz;
    u_xlat5.xyz = u_xlat5.xyz + _SPCubeMapOffset.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat11 = u_xlat11 + u_xlat11;
    u_xlat5.xyz = u_xlat2.xyz * (-vec3(u_xlat11)) + u_xlat5.xyz;
    u_xlat10_5.xyz = texture(_SPCubeMap, u_xlat5.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_5.xyz * _SPCubeMapColor.xyz;
    u_xlat5.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_9.xyz);
    u_xlat5.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat11 = u_xlat11 * 1.70000005 + (-u_xlat22);
    u_xlat11 = u_xlat11 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat5.xyz);
    u_xlat8.xyz = vec3(u_xlat11) * u_xlat8.xyz + u_xlat5.xyz;
    u_xlat16_9.xyz = (u_xlati6.y != 0) ? u_xlat5.xyz : u_xlat8.xyz;
    u_xlat11 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati6.x != 0) ? u_xlat16_9.xyz : u_xlat5.xyz;
    u_xlat4.xyz = (-u_xlat16_4.xyz);
    u_xlat4.w = (-u_xlat0.x);
    u_xlat4 = u_xlat4 + u_xlat16_7;
    u_xlat4 = vec4(u_xlat11) * u_xlat4;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat10_1.xyz + u_xlat4.xyz;
    u_xlat16_3.x = u_xlat0.w * vs_COLOR0.w + u_xlat4.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat33 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * vs_TEXCOORD5.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat33 = (-u_xlat33) + 1.00100005;
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = min(u_xlat33, 1.0);
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _RGShininess;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = u_xlat33 * _RGScale + _RGBias;
    u_xlat16_14 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_14 * _RGRatio;
    u_xlat12.xyz = vec3(u_xlat33) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat12.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat16_3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
float u_xlat17;
int u_xlati17;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    u_xlat11 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat3.xyz = vec3(u_xlat11) * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat3.xy = vec2(u_xlat17) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
    u_xlat16_4 = u_xlat3.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati17 = int(u_xlat16_4);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat11) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati17) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat12.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD3.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
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
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec2 u_xlat6;
lowp vec4 u_xlat10_6;
ivec2 u_xlati6;
mediump vec4 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat12;
mediump float u_xlat16_14;
float u_xlat22;
bvec2 u_xlatb22;
float u_xlat33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat0.w * vs_COLOR0.w;
    u_xlat11 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD6.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat10_6 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_7.w = u_xlat10_6.w * _SPOpaqueness;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat22 = u_xlat10_8.x * _SPNoiseScaler;
    u_xlat22 = u_xlat22 * 1.99000001 + -1.0;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + (-_WorldSpaceCameraPos.xyz);
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat8.xyz;
    u_xlat5.xyz = u_xlat5.xyz + _SPCubeMapOffset.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat11 = u_xlat11 + u_xlat11;
    u_xlat5.xyz = u_xlat2.xyz * (-vec3(u_xlat11)) + u_xlat5.xyz;
    u_xlat10_5.xyz = texture(_SPCubeMap, u_xlat5.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_5.xyz * _SPCubeMapColor.xyz;
    u_xlat5.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_9.xyz);
    u_xlat5.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat11 = u_xlat11 * 1.70000005 + (-u_xlat22);
    u_xlat11 = u_xlat11 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat5.xyz);
    u_xlat8.xyz = vec3(u_xlat11) * u_xlat8.xyz + u_xlat5.xyz;
    u_xlat16_9.xyz = (u_xlati6.y != 0) ? u_xlat5.xyz : u_xlat8.xyz;
    u_xlat11 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati6.x != 0) ? u_xlat16_9.xyz : u_xlat5.xyz;
    u_xlat4.xyz = (-u_xlat16_4.xyz);
    u_xlat4.w = (-u_xlat0.x);
    u_xlat4 = u_xlat4 + u_xlat16_7;
    u_xlat4 = vec4(u_xlat11) * u_xlat4;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat10_1.xyz + u_xlat4.xyz;
    u_xlat16_3.x = u_xlat0.w * vs_COLOR0.w + u_xlat4.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat33 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * vs_TEXCOORD5.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat33 = (-u_xlat33) + 1.00100005;
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = min(u_xlat33, 1.0);
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _RGShininess;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = u_xlat33 * _RGScale + _RGBias;
    u_xlat16_14 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_14 * _RGRatio;
    u_xlat12.xyz = vec3(u_xlat33) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat12.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat16_3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
float u_xlat11;
vec2 u_xlat12;
float u_xlat15;
float u_xlat17;
int u_xlati17;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat11 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * u_xlat2.xyz;
    u_xlat11 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat3.xyz = vec3(u_xlat11) * _WorldSpaceLightPos0.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat3.xy = vec2(u_xlat17) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat3.xy;
    u_xlat16_4 = u_xlat3.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati17 = int(u_xlat16_4);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat11) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD6.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati17) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat5 = u_xlat0.w + u_xlat0.y;
    u_xlat15 = u_xlat0.x * in_POSITION0.x;
    u_xlat12.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat12.y = u_xlat15 * 0.25 + u_xlat5;
    vs_TEXCOORD3.zw = u_xlat12.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
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
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec2 u_xlat6;
lowp vec4 u_xlat10_6;
ivec2 u_xlati6;
mediump vec4 u_xlat16_7;
vec3 u_xlat8;
lowp vec3 u_xlat10_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
float u_xlat11;
vec3 u_xlat12;
mediump float u_xlat16_14;
float u_xlat22;
bvec2 u_xlatb22;
float u_xlat33;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb22.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb22.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb22.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.x = u_xlat0.w * vs_COLOR0.w;
    u_xlat11 = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat2.xyz = vec3(u_xlat11) * vs_TEXCOORD6.xyz;
    u_xlat5.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat10_6 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_7.w = u_xlat10_6.w * _SPOpaqueness;
    u_xlat10_8.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat22 = u_xlat10_8.x * _SPNoiseScaler;
    u_xlat22 = u_xlat22 * 1.99000001 + -1.0;
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + (-_WorldSpaceCameraPos.xyz);
    u_xlat11 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat11 = inversesqrt(u_xlat11);
    u_xlat8.xyz = u_xlat10_8.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat11) + u_xlat8.xyz;
    u_xlat5.xyz = u_xlat5.xyz + _SPCubeMapOffset.xyz;
    u_xlat11 = dot(u_xlat5.xyz, u_xlat2.xyz);
    u_xlat11 = u_xlat11 + u_xlat11;
    u_xlat5.xyz = u_xlat2.xyz * (-vec3(u_xlat11)) + u_xlat5.xyz;
    u_xlat10_5.xyz = texture(_SPCubeMap, u_xlat5.xyz).xyz;
    u_xlat16_9.xyz = u_xlat10_6.xyz * _SPOldColor.xyz;
    u_xlat16_10.xyz = u_xlat10_5.xyz * _SPCubeMapColor.xyz;
    u_xlat5.xyz = u_xlat16_10.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_9.xyz);
    u_xlat5.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat5.xyz + u_xlat16_9.xyz;
    u_xlat11 = _SPNoiseScaler * _SPTransition;
    u_xlat6.xy = vec2(u_xlat11) * vec2(1.70000005, 1.5) + (-vec2(u_xlat22));
    u_xlat6.xy = u_xlat6.xy + vec2(1.0, 1.0);
    u_xlat6.xy = floor(u_xlat6.xy);
    u_xlat6.xy = max(u_xlat6.xy, vec2(0.0, 0.0));
    u_xlati6.xy = ivec2(u_xlat6.xy);
    u_xlat11 = u_xlat11 * 1.70000005 + (-u_xlat22);
    u_xlat11 = u_xlat11 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat5.xyz);
    u_xlat8.xyz = vec3(u_xlat11) * u_xlat8.xyz + u_xlat5.xyz;
    u_xlat16_9.xyz = (u_xlati6.y != 0) ? u_xlat5.xyz : u_xlat8.xyz;
    u_xlat11 = (u_xlati6.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati6.x != 0) ? u_xlat16_9.xyz : u_xlat5.xyz;
    u_xlat4.xyz = (-u_xlat16_4.xyz);
    u_xlat4.w = (-u_xlat0.x);
    u_xlat4 = u_xlat4 + u_xlat16_7;
    u_xlat4 = vec4(u_xlat11) * u_xlat4;
    u_xlat0.xyz = u_xlat16_3.xyz * u_xlat10_1.xyz + u_xlat4.xyz;
    u_xlat16_3.x = u_xlat0.w * vs_COLOR0.w + u_xlat4.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat33 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * vs_TEXCOORD5.xyz;
    u_xlat33 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat33 = (-u_xlat33) + 1.00100005;
    u_xlat33 = max(u_xlat33, 0.00100000005);
    u_xlat33 = min(u_xlat33, 1.0);
    u_xlat33 = log2(u_xlat33);
    u_xlat33 = u_xlat33 * _RGShininess;
    u_xlat33 = exp2(u_xlat33);
    u_xlat33 = u_xlat33 * _RGScale + _RGBias;
    u_xlat16_14 = u_xlat33;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_14 = min(max(u_xlat16_14, 0.0), 1.0);
#else
    u_xlat16_14 = clamp(u_xlat16_14, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_14 * _RGRatio;
    u_xlat12.xyz = vec3(u_xlat33) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat12.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat16_3.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat13;
vec2 u_xlat14;
float u_xlat18;
float u_xlat20;
float u_xlat21;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = u_xlat2.xx * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati2 = int(u_xlat16_4);
    u_xlat8.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat21);
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat13) + u_xlat8.xyz;
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat13 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat8.xyz = vec3(u_xlat13) * u_xlat5.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _Shininess;
    u_xlat13 = exp2(u_xlat13);
    vs_TEXCOORD2.xy = (int(u_xlati2) != 0) ? vec2(u_xlat13) : vec2(0.0250000004, 0.0250000004);
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat13 = u_xlat2.w + u_xlat2.y;
    u_xlat8.x = u_xlat2.x * in_POSITION0.x;
    u_xlat14.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat14.y = u_xlat8.x * 0.25 + u_xlat13;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
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
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
ivec2 u_xlati5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat10;
bvec2 u_xlatb18;
float u_xlat28;
float u_xlat29;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat10_3 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_4.w = u_xlat10_3.w * _SPOpaqueness;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat29 = u_xlat10_5.x * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28) + (-_WorldSpaceCameraPos.xyz);
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat28)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_6.xyz;
    u_xlat28 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat28) * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat28 = u_xlat28 * 1.70000005 + (-u_xlat29);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat28) * u_xlat8.xyz + u_xlat2.xyz;
    u_xlat16_6.xyz = (u_xlati5.y != 0) ? u_xlat2.xyz : u_xlat8.xyz;
    u_xlat28 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_4.xyz = (u_xlati5.x != 0) ? u_xlat16_6.xyz : u_xlat2.xyz;
    u_xlat2 = (-u_xlat0) + u_xlat16_4;
    u_xlat0 = vec4(u_xlat28) * u_xlat2 + u_xlat0;
    u_xlat28 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_4.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat16_4.x * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat1.xzw + u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_4.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat13;
vec2 u_xlat14;
float u_xlat18;
float u_xlat20;
float u_xlat21;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = u_xlat2.xx * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati2 = int(u_xlat16_4);
    u_xlat8.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat21);
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat13) + u_xlat8.xyz;
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat13 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat8.xyz = vec3(u_xlat13) * u_xlat5.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _Shininess;
    u_xlat13 = exp2(u_xlat13);
    vs_TEXCOORD2.xy = (int(u_xlati2) != 0) ? vec2(u_xlat13) : vec2(0.0250000004, 0.0250000004);
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat13 = u_xlat2.w + u_xlat2.y;
    u_xlat8.x = u_xlat2.x * in_POSITION0.x;
    u_xlat14.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat14.y = u_xlat8.x * 0.25 + u_xlat13;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
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
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
ivec2 u_xlati5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat10;
bvec2 u_xlatb18;
float u_xlat28;
float u_xlat29;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat10_3 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_4.w = u_xlat10_3.w * _SPOpaqueness;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat29 = u_xlat10_5.x * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28) + (-_WorldSpaceCameraPos.xyz);
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat28)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_6.xyz;
    u_xlat28 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat28) * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat28 = u_xlat28 * 1.70000005 + (-u_xlat29);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat28) * u_xlat8.xyz + u_xlat2.xyz;
    u_xlat16_6.xyz = (u_xlati5.y != 0) ? u_xlat2.xyz : u_xlat8.xyz;
    u_xlat28 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_4.xyz = (u_xlati5.x != 0) ? u_xlat16_6.xyz : u_xlat2.xyz;
    u_xlat2 = (-u_xlat0) + u_xlat16_4;
    u_xlat0 = vec4(u_xlat28) * u_xlat2 + u_xlat0;
    u_xlat28 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_4.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat16_4.x * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat1.xzw + u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_4.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_4LightPosX0;
uniform 	vec4 unity_4LightPosY0;
uniform 	vec4 unity_4LightPosZ0;
uniform 	mediump vec4 unity_4LightAtten0;
uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _Shininess;
uniform 	float _DitherAlpha;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD8;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
int u_xlati2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
vec3 u_xlat8;
float u_xlat13;
vec2 u_xlat14;
float u_xlat18;
float u_xlat20;
float u_xlat21;
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
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_COLOR0.w = _Opaqueness;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat13 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat20 = inversesqrt(u_xlat20);
    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
    u_xlat2.x = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = u_xlat2.xx * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati2 = int(u_xlat16_4);
    u_xlat8.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat21 = dot(u_xlat8.xyz, u_xlat8.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat21);
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat13) + u_xlat8.xyz;
    vs_TEXCOORD5.xyz = u_xlat8.xyz;
    u_xlat13 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat8.xyz = vec3(u_xlat13) * u_xlat5.xyz;
    u_xlat13 = dot(u_xlat3.xyz, u_xlat8.xyz);
    u_xlat13 = max(u_xlat13, 0.0);
    u_xlat13 = log2(u_xlat13);
    u_xlat13 = u_xlat13 * _Shininess;
    u_xlat13 = exp2(u_xlat13);
    vs_TEXCOORD2.xy = (int(u_xlati2) != 0) ? vec2(u_xlat13) : vec2(0.0250000004, 0.0250000004);
    u_xlat2 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat13 = u_xlat2.w + u_xlat2.y;
    u_xlat8.x = u_xlat2.x * in_POSITION0.x;
    u_xlat14.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat14.y = u_xlat8.x * 0.25 + u_xlat13;
    vs_TEXCOORD3.zw = u_xlat14.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    vs_TEXCOORD4.xyz = u_xlat0.xyz / u_xlat0.www;
    vs_TEXCOORD6.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD7.w = u_xlat1.w;
    vs_TEXCOORD7.xy = u_xlat2.zz + u_xlat2.xw;
    vs_TEXCOORD7.z = _DitherAlpha;
    u_xlat1 = (-u_xlat0.yyyy) + unity_4LightPosY0;
    u_xlat2 = u_xlat3.yyyy * u_xlat1;
    u_xlat1 = u_xlat1 * u_xlat1;
    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
    u_xlat2 = u_xlat4 * u_xlat3.xxxx + u_xlat2;
    u_xlat2 = u_xlat0 * u_xlat3.zzzz + u_xlat2;
    u_xlat1 = u_xlat4 * u_xlat4 + u_xlat1;
    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat1;
    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
    u_xlat1 = inversesqrt(u_xlat0);
    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
    vs_TEXCOORD8.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPIntensity;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPTransitionColor;
uniform 	mediump float _SPOpaqueness;
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
uniform 	vec4 _Color;
uniform 	vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in highp vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD8;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
lowp vec4 u_xlat10_3;
mediump vec4 u_xlat16_4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
ivec2 u_xlati5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
float u_xlat10;
bvec2 u_xlatb18;
float u_xlat28;
float u_xlat29;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD7.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD7.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD7.yx / vs_TEXCOORD7.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb18.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb18.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb18.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD7.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _Color;
    u_xlat0.xyz = u_xlat0.xyz * _EnvColor.xyz;
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat0.w = u_xlat0.w * vs_COLOR0.w;
    u_xlat0.xyz = u_xlat16_3.xyz * vs_TEXCOORD8.xyz + u_xlat16_3.xyz;
    u_xlat1.x = dot(vs_TEXCOORD6.xyz, vs_TEXCOORD6.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * vs_TEXCOORD6.xyz;
    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat10_3 = texture(_SPTex, vs_TEXCOORD3.xy);
    u_xlat16_4.w = u_xlat10_3.w * _SPOpaqueness;
    u_xlat10_5.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat29 = u_xlat10_5.x * _SPNoiseScaler;
    u_xlat29 = u_xlat29 * 1.99000001 + -1.0;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28) + (-_WorldSpaceCameraPos.xyz);
    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat5.xyz = u_xlat10_5.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat28) + u_xlat5.xyz;
    u_xlat2.xyz = u_xlat2.xyz + _SPCubeMapOffset.xyz;
    u_xlat28 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat28 = u_xlat28 + u_xlat28;
    u_xlat2.xyz = u_xlat1.xyz * (-vec3(u_xlat28)) + u_xlat2.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_6.xyz = u_xlat10_3.xyz * _SPOldColor.xyz;
    u_xlat16_7.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_7.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_6.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_6.xyz;
    u_xlat28 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat28) * vec2(1.70000005, 1.5) + (-vec2(u_xlat29));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat28 = u_xlat28 * 1.70000005 + (-u_xlat29);
    u_xlat28 = u_xlat28 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat28 = min(max(u_xlat28, 0.0), 1.0);
#else
    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
#endif
    u_xlat8.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat8.xyz = vec3(u_xlat28) * u_xlat8.xyz + u_xlat2.xyz;
    u_xlat16_6.xyz = (u_xlati5.y != 0) ? u_xlat2.xyz : u_xlat8.xyz;
    u_xlat28 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_4.xyz = (u_xlati5.x != 0) ? u_xlat16_6.xyz : u_xlat2.xyz;
    u_xlat2 = (-u_xlat0) + u_xlat16_4;
    u_xlat0 = vec4(u_xlat28) * u_xlat2 + u_xlat0;
    u_xlat28 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat28 = inversesqrt(u_xlat28);
    u_xlat2.xyz = vec3(u_xlat28) * vs_TEXCOORD5.xyz;
    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat1.x = (-u_xlat1.x) + 1.00100005;
    u_xlat1.x = max(u_xlat1.x, 0.00100000005);
    u_xlat1.x = min(u_xlat1.x, 1.0);
    u_xlat1.x = log2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGShininess;
    u_xlat1.x = exp2(u_xlat1.x);
    u_xlat1.x = u_xlat1.x * _RGScale + _RGBias;
    u_xlat16_4.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat10 = u_xlat16_4.x * _RGRatio;
    u_xlat1.xzw = u_xlat1.xxx * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = vec3(u_xlat10) * u_xlat1.xzw + u_xlat0.xyz;
    u_xlat16_4.x = u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    SV_Target0.w = u_xlat16_4.x;
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
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" }
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
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "RIM_GLOW" }
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
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" }
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
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "VERTEXLIGHT_ON" "SPECIAL_STATE" "RIM_GLOW" }
""
}
}
}
 Pass {
  Name "OUTLINE"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 96172
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0.w = _OutlineColor.w * _Opaqueness;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_2;
bvec2 u_xlatb6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_2 = u_xlat10_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0.w = _OutlineColor.w * _Opaqueness;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_2;
bvec2 u_xlatb6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_2 = u_xlat10_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0.w = _OutlineColor.w * _Opaqueness;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform lowp sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
mediump float u_xlat16_2;
bvec2 u_xlatb6;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb6.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb6.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb6.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat16_2 = u_xlat10_0 * vs_COLOR0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2 = min(max(u_xlat16_2, 0.0), 1.0);
#else
    u_xlat16_2 = clamp(u_xlat16_2, 0.0, 1.0);
#endif
    SV_Target0.xyz = vs_COLOR0.xyz;
    SV_Target0.w = u_xlat16_2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0.w = _OutlineColor.w * _Opaqueness;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat3.x = u_xlat0.w + u_xlat0.y;
    u_xlat9 = u_xlat0.x * in_POSITION0.x;
    u_xlat7.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat7.y = u_xlat9 * 0.25 + u_xlat3.x;
    vs_TEXCOORD2.xy = u_xlat7.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
int u_xlati1;
float u_xlat3;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0.w = u_xlat10_0 * vs_COLOR0.w;
    u_xlat10_1 = texture(_SPNoiseTex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = u_xlat10_1 * _SPNoiseScaler;
    u_xlat1.x = u_xlat1.x * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat1.x = u_xlat3 * 1.70000005 + (-u_xlat1.x);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = (int(u_xlati1) != 0) ? _SPOutlineColor : u_xlat0;
    u_xlat16_0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0.w = _OutlineColor.w * _Opaqueness;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat3.x = u_xlat0.w + u_xlat0.y;
    u_xlat9 = u_xlat0.x * in_POSITION0.x;
    u_xlat7.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat7.y = u_xlat9 * 0.25 + u_xlat3.x;
    vs_TEXCOORD2.xy = u_xlat7.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
int u_xlati1;
float u_xlat3;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0.w = u_xlat10_0 * vs_COLOR0.w;
    u_xlat10_1 = texture(_SPNoiseTex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = u_xlat10_1 * _SPNoiseScaler;
    u_xlat1.x = u_xlat1.x * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat1.x = u_xlat3 * 1.70000005 + (-u_xlat1.x);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = (int(u_xlati1) != 0) ? _SPOutlineColor : u_xlat0;
    u_xlat16_0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _DitherAlpha;
uniform 	mediump vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat1.xyz;
    u_xlat0.x = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
    u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xy = vec2(u_xlat6) * u_xlat0.xy;
    u_xlat3.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat3.xy;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xy = u_xlat0.xy * vec2(_Outline) + u_xlat1.xy;
    gl_Position = u_xlat1;
    vs_COLOR0.w = _OutlineColor.w * _Opaqueness;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat3.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat3.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
    vs_TEXCOORD0.z = _DitherAlpha;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat3.x = u_xlat0.w + u_xlat0.y;
    u_xlat9 = u_xlat0.x * in_POSITION0.x;
    u_xlat7.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat7.y = u_xlat9 * 0.25 + u_xlat3.x;
    vs_TEXCOORD2.xy = u_xlat7.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump vec4 _SPOutlineColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp float u_xlat10_1;
int u_xlati1;
float u_xlat3;
bvec2 u_xlatb4;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD0.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD0.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD0.yx / vs_TEXCOORD0.ww;
        u_xlat0.xy = u_xlat0.xy * _ScreenParams.yx;
        u_xlat0.xy = u_xlat0.xy * vec2(0.25, 0.25);
        u_xlatb4.xy = greaterThanEqual(u_xlat0.xyxy, (-u_xlat0.xyxy)).xy;
        u_xlat0.xy = fract(abs(u_xlat0.xy));
        u_xlat0.x = (u_xlatb4.x) ? u_xlat0.x : (-u_xlat0.x);
        u_xlat0.y = (u_xlatb4.y) ? u_xlat0.y : (-u_xlat0.y);
        u_xlat0.xy = u_xlat0.xy * vec2(4.0, 4.0);
        u_xlatu0.xy = uvec2(u_xlat0.xy);
        u_xlat1.x = dot(hlslcc_mtx4x4_DITHERMATRIX[0], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.y = dot(hlslcc_mtx4x4_DITHERMATRIX[1], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.z = dot(hlslcc_mtx4x4_DITHERMATRIX[2], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat1.w = dot(hlslcc_mtx4x4_DITHERMATRIX[3], ImmCB_0_0_0[int(u_xlatu0.y)]);
        u_xlat0.x = dot(u_xlat1, ImmCB_0_0_0[int(u_xlatu0.x)]);
        u_xlat0.x = vs_TEXCOORD0.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy).w;
    u_xlat0.w = u_xlat10_0 * vs_COLOR0.w;
    u_xlat10_1 = texture(_SPNoiseTex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = u_xlat10_1 * _SPNoiseScaler;
    u_xlat1.x = u_xlat1.x * 1.99000001 + -1.0;
    u_xlat3 = _SPNoiseScaler * _SPTransition;
    u_xlat1.x = u_xlat3 * 1.70000005 + (-u_xlat1.x);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xyz = vs_COLOR0.xyz;
    u_xlat16_0 = (int(u_xlati1) != 0) ? _SPOutlineColor : u_xlat0;
    u_xlat16_0.w = u_xlat16_0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.w = min(max(u_xlat16_0.w, 0.0), 1.0);
#else
    u_xlat16_0.w = clamp(u_xlat16_0.w, 0.0, 1.0);
#endif
    SV_Target0 = u_xlat16_0;
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
}
}
}
CustomEditor "MoleMole.CharacterShaderEditorBase"
}