//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Simple/Simple_Emission_BOSS030" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
[Toggle] _OutlineUseTangent ("Use Tangent For Outline", Float) = 0
_SpecMulti ("Specular Multiply", Float) = 1
_Shininess ("Shininess", Range(0.1, 100)) = 2
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_Ramp ("Toon Ramp (RGB)", 2D) = "white" { }
_SpecRamp ("Specular Ramp (RGB)", 2D) = "black" { }
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Emission ("Emission", Range(1, 100)) = 1
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
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
[Toggle(TRANSPARENT)] _Transparent ("Transparent", Float) = 0
_MainAlpha ("Main Alpha Range(0, 1)", Range(0, 1)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_AdditiveLightIntensity ("Addtive Light Intensity", Range(0, 5)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Geometry" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Geometry" }
  GpuProgramID 13822
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_5;
bool u_xlatb6;
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
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.x + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.z + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = min(u_xlat13, 1.0);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = _FadeDistance * u_xlat13 + 0.100000001;
    u_xlat18 = u_xlat18 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat18 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb6 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb6) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_5;
bool u_xlatb6;
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
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.x + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.z + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = min(u_xlat13, 1.0);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = _FadeDistance * u_xlat13 + 0.100000001;
    u_xlat18 = u_xlat18 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat18 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb6 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb6) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec2 u_xlat4;
mediump float u_xlat16_5;
bool u_xlatb6;
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
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.x + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.z + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = min(u_xlat13, 1.0);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = _FadeDistance * u_xlat13 + 0.100000001;
    u_xlat18 = u_xlat18 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat18 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati18) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb6 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb6) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
uniform 	mediump float _AdditiveLightIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
bool u_xlatb18;
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
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.x + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.z + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = min(u_xlat13, 1.0);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = _FadeDistance * u_xlat13 + 0.100000001;
    u_xlat18 = u_xlat18 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat18 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    u_xlat16_5.x = u_xlat4.y + 0.5;
    u_xlat16_5.x = floor(u_xlat16_5.x);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlati18 = int(u_xlat16_5.x);
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
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb18 = 0.5<in_COLOR0.x;
#endif
    u_xlat18 = (u_xlatb18) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb1 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb1) ? 1.0 : u_xlat18;
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
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(_AdditiveLightIntensity);
    vs_TEXCOORD7.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD7.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
uniform 	mediump float _AdditiveLightIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
bool u_xlatb18;
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
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.x + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.z + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = min(u_xlat13, 1.0);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = _FadeDistance * u_xlat13 + 0.100000001;
    u_xlat18 = u_xlat18 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat18 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    u_xlat16_5.x = u_xlat4.y + 0.5;
    u_xlat16_5.x = floor(u_xlat16_5.x);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlati18 = int(u_xlat16_5.x);
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
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb18 = 0.5<in_COLOR0.x;
#endif
    u_xlat18 = (u_xlatb18) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb1 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb1) ? 1.0 : u_xlat18;
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
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(_AdditiveLightIntensity);
    vs_TEXCOORD7.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD7.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
uniform 	mediump float _AdditiveLightIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump vec3 u_xlat16_5;
float u_xlat13;
float u_xlat18;
int u_xlati18;
bool u_xlatb18;
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
    u_xlat18 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat18;
    u_xlat18 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat18;
    u_xlat18 = u_xlat18 * in_POSITION0.y;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.x + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.z + u_xlat18;
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat13;
    u_xlat18 = u_xlat13 * in_POSITION0.w + u_xlat18;
    u_xlat18 = (-u_xlat18) + (-_ProjectionParams.y);
    u_xlat18 = u_xlat18 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = min(u_xlat13, 1.0);
    u_xlat13 = (-u_xlat13) + 1.0;
    u_xlat13 = _FadeDistance * u_xlat13 + 0.100000001;
    u_xlat18 = u_xlat18 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat18 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    u_xlat16_5.x = u_xlat4.y + 0.5;
    u_xlat16_5.x = floor(u_xlat16_5.x);
    u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
    u_xlati18 = int(u_xlat16_5.x);
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
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    u_xlat18 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat18 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb18 = 0.5<in_COLOR0.x;
#endif
    u_xlat18 = (u_xlatb18) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb1 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb1) ? 1.0 : u_xlat18;
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
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_5.xyz = u_xlat0.xyz * vec3(_AdditiveLightIntensity);
    vs_TEXCOORD7.xyz = u_xlat16_5.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat0.xyz * vs_TEXCOORD7.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb5;
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
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat15;
    u_xlat15 = u_xlat15 * in_POSITION0.y;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.x + u_xlat15;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.z + u_xlat15;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.w + u_xlat15;
    u_xlat15 = (-u_xlat15) + (-_ProjectionParams.y);
    u_xlat15 = u_xlat15 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat11 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat11 = sqrt(u_xlat11);
    u_xlat11 = min(u_xlat11, 1.0);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = _FadeDistance * u_xlat11 + 0.100000001;
    u_xlat15 = u_xlat15 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat15 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati11) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb5 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb5) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
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
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb5;
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
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat15;
    u_xlat15 = u_xlat15 * in_POSITION0.y;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.x + u_xlat15;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.z + u_xlat15;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.w + u_xlat15;
    u_xlat15 = (-u_xlat15) + (-_ProjectionParams.y);
    u_xlat15 = u_xlat15 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat11 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat11 = sqrt(u_xlat11);
    u_xlat11 = min(u_xlat11, 1.0);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = _FadeDistance * u_xlat11 + 0.100000001;
    u_xlat15 = u_xlat15 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat15 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati11) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb5 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb5) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
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
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
bool u_xlatb5;
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
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat15;
    u_xlat15 = u_xlat15 * in_POSITION0.y;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.x + u_xlat15;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.z + u_xlat15;
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat11;
    u_xlat15 = u_xlat11 * in_POSITION0.w + u_xlat15;
    u_xlat15 = (-u_xlat15) + (-_ProjectionParams.y);
    u_xlat15 = u_xlat15 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat11 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat11 = sqrt(u_xlat11);
    u_xlat11 = min(u_xlat11, 1.0);
    u_xlat11 = (-u_xlat11) + 1.0;
    u_xlat11 = _FadeDistance * u_xlat11 + 0.100000001;
    u_xlat15 = u_xlat15 / u_xlat11;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat15 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = log2(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _Shininess;
    u_xlat0.x = exp2(u_xlat0.x);
    vs_TEXCOORD2.xy = (int(u_xlati11) != 0) ? u_xlat0.xx : vec2(0.0250000004, 0.0250000004);
    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat0.x * 0.5;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb5 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb5) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
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
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
uniform 	mediump float _AdditiveLightIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
int u_xlati15;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.x + u_xlat21;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.z + u_xlat21;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = min(u_xlat15, 1.0);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = _FadeDistance * u_xlat15 + 0.100000001;
    u_xlat21 = u_xlat21 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat21 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati15 = int(u_xlat16_4);
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Shininess;
    u_xlat21 = exp2(u_xlat21);
    vs_TEXCOORD2.xy = (int(u_xlati15) != 0) ? vec2(u_xlat21) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat21 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb21 = 0.5<in_COLOR0.x;
#endif
    u_xlat21 = (u_xlatb21) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb1 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb1) ? 1.0 : u_xlat21;
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
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(_AdditiveLightIntensity);
    vs_TEXCOORD7.xyz = u_xlat16_6.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD7.xyz + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
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
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
uniform 	mediump float _AdditiveLightIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
int u_xlati15;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.x + u_xlat21;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.z + u_xlat21;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = min(u_xlat15, 1.0);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = _FadeDistance * u_xlat15 + 0.100000001;
    u_xlat21 = u_xlat21 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat21 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati15 = int(u_xlat16_4);
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Shininess;
    u_xlat21 = exp2(u_xlat21);
    vs_TEXCOORD2.xy = (int(u_xlati15) != 0) ? vec2(u_xlat21) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat21 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb21 = 0.5<in_COLOR0.x;
#endif
    u_xlat21 = (u_xlatb21) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb1 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb1) ? 1.0 : u_xlat21;
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
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(_AdditiveLightIntensity);
    vs_TEXCOORD7.xyz = u_xlat16_6.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD7.xyz + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
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
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
uniform 	mediump float _AdditiveLightIntensity;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
out highp vec4 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec3 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec3 u_xlat5;
mediump vec3 u_xlat16_6;
float u_xlat15;
int u_xlati15;
float u_xlat21;
bool u_xlatb21;
float u_xlat23;
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
    u_xlat21 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat21;
    u_xlat21 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat21;
    u_xlat21 = u_xlat21 * in_POSITION0.y;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.x + u_xlat21;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.z + u_xlat21;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
    u_xlat21 = u_xlat15 * in_POSITION0.w + u_xlat21;
    u_xlat21 = (-u_xlat21) + (-_ProjectionParams.y);
    u_xlat21 = u_xlat21 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat15 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat15 = sqrt(u_xlat15);
    u_xlat15 = min(u_xlat15, 1.0);
    u_xlat15 = (-u_xlat15) + 1.0;
    u_xlat15 = _FadeDistance * u_xlat15 + 0.100000001;
    u_xlat21 = u_xlat21 / u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat21 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat21 = dot(_WorldSpaceLightPos0, _WorldSpaceLightPos0);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * _WorldSpaceLightPos0.xyz;
    u_xlat3.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat3.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat3.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat15 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
    u_xlat15 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat2.xy = vec2(u_xlat15) * vec2(0.497500002, 0.497500002) + vec2(0.5, 0.5);
    vs_TEXCOORD1.xy = u_xlat2.xy;
    u_xlat16_4 = u_xlat2.y + 0.5;
    u_xlat16_4 = floor(u_xlat16_4);
    u_xlat16_4 = max(u_xlat16_4, 0.0);
    u_xlati15 = int(u_xlat16_4);
    u_xlat2.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat23 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat23 = inversesqrt(u_xlat23);
    u_xlat2.xyz = vec3(u_xlat23) * u_xlat2.xyz;
    u_xlat5.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
    vs_TEXCOORD5.xyz = u_xlat2.xyz;
    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat21 = inversesqrt(u_xlat21);
    u_xlat2.xyz = vec3(u_xlat21) * u_xlat5.xyz;
    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
    u_xlat21 = max(u_xlat21, 0.0);
    u_xlat21 = log2(u_xlat21);
    u_xlat21 = u_xlat21 * _Shininess;
    u_xlat21 = exp2(u_xlat21);
    vs_TEXCOORD2.xy = (int(u_xlati15) != 0) ? vec2(u_xlat21) : vec2(0.0250000004, 0.0250000004);
    vs_TEXCOORD4.xyz = u_xlat3.xyz;
    u_xlat21 = u_xlat1.y * _ProjectionParams.x;
    u_xlat2.w = u_xlat21 * 0.5;
    u_xlat2.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat2.zz + u_xlat2.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb21 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb21 = 0.5<in_COLOR0.x;
#endif
    u_xlat21 = (u_xlatb21) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb1 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb1) ? 1.0 : u_xlat21;
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
    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
    u_xlat16_6.xyz = u_xlat0.xyz * vec3(_AdditiveLightIntensity);
    vs_TEXCOORD7.xyz = u_xlat16_6.xyz;
    vs_TEXCOORD7.w = 0.0;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
in highp vec4 vs_TEXCOORD7;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
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
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD7.xyz + u_xlat0.xyz;
    u_xlat12 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * vs_TEXCOORD4.xyz;
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
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
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
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat13;
    u_xlat13 = u_xlat13 * in_POSITION0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.x + u_xlat13;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.z + u_xlat13;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.w + u_xlat13;
    u_xlat13 = (-u_xlat13) + (-_ProjectionParams.y);
    u_xlat13 = u_xlat13 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = _FadeDistance * u_xlat2.x + 0.100000001;
    u_xlat13 = u_xlat13 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat13 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
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
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb6 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb6) ? 1.0 : u_xlat0.x;
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
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb18;
float u_xlat27;
float u_xlat28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat28 = u_xlat10_6.x * _SPNoiseScaler;
    u_xlat28 = u_xlat28 * 1.99000001 + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat2.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat4.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_7.xyz;
    u_xlat27 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat27) * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat27 = u_xlat27 * 1.70000005 + (-u_xlat28);
    u_xlat27 = u_xlat27 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = (u_xlati4.y != 0) ? u_xlat2.xyz : u_xlat5.xyz;
    u_xlat27 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati4.x != 0) ? u_xlat16_7.xyz : u_xlat2.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
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
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat13;
    u_xlat13 = u_xlat13 * in_POSITION0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.x + u_xlat13;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.z + u_xlat13;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.w + u_xlat13;
    u_xlat13 = (-u_xlat13) + (-_ProjectionParams.y);
    u_xlat13 = u_xlat13 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = _FadeDistance * u_xlat2.x + 0.100000001;
    u_xlat13 = u_xlat13 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat13 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
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
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb6 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb6) ? 1.0 : u_xlat0.x;
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
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb18;
float u_xlat27;
float u_xlat28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat28 = u_xlat10_6.x * _SPNoiseScaler;
    u_xlat28 = u_xlat28 * 1.99000001 + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat2.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat4.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_7.xyz;
    u_xlat27 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat27) * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat27 = u_xlat27 * 1.70000005 + (-u_xlat28);
    u_xlat27 = u_xlat27 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = (u_xlati4.y != 0) ? u_xlat2.xyz : u_xlat5.xyz;
    u_xlat27 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati4.x != 0) ? u_xlat16_7.xyz : u_xlat2.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD7;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
bool u_xlatb6;
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
    u_xlat13 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat13;
    u_xlat13 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat13;
    u_xlat13 = u_xlat13 * in_POSITION0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.x + u_xlat13;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.z + u_xlat13;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2.x;
    u_xlat13 = u_xlat2.x * in_POSITION0.w + u_xlat13;
    u_xlat13 = (-u_xlat13) + (-_ProjectionParams.y);
    u_xlat13 = u_xlat13 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = _FadeDistance * u_xlat2.x + 0.100000001;
    u_xlat13 = u_xlat13 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat13 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat3.xyz;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
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
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb6 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb6) ? 1.0 : u_xlat0.x;
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
uniform 	float _SPTransitionEmissionScaler;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	vec4 _Color;
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD7;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
ivec2 u_xlati4;
vec3 u_xlat5;
lowp vec3 u_xlat10_5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
bvec2 u_xlatb18;
float u_xlat27;
float u_xlat28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat28 = u_xlat10_6.x * _SPNoiseScaler;
    u_xlat28 = u_xlat28 * 1.99000001 + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat2.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat4.xyz;
    u_xlat10_2.xyz = texture(_SPCubeMap, u_xlat2.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_2.xyz * _SPCubeMapColor.xyz;
    u_xlat2.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat2.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat2.xyz + u_xlat16_7.xyz;
    u_xlat27 = _SPNoiseScaler * _SPTransition;
    u_xlat4.xy = vec2(u_xlat27) * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat4.xy = u_xlat4.xy + vec2(1.0, 1.0);
    u_xlat4.xy = floor(u_xlat4.xy);
    u_xlat4.xy = max(u_xlat4.xy, vec2(0.0, 0.0));
    u_xlati4.xy = ivec2(u_xlat4.xy);
    u_xlat27 = u_xlat27 * 1.70000005 + (-u_xlat28);
    u_xlat27 = u_xlat27 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat5.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat2.xyz);
    u_xlat5.xyz = vec3(u_xlat27) * u_xlat5.xyz + u_xlat2.xyz;
    u_xlat16_7.xyz = (u_xlati4.y != 0) ? u_xlat2.xyz : u_xlat5.xyz;
    u_xlat27 = (u_xlati4.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati4.x != 0) ? u_xlat16_7.xyz : u_xlat2.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xyz + u_xlat16_7.xyz;
    SV_Target0.xyz = vec3(u_xlat27) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
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
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat11;
    u_xlat11 = u_xlat11 * in_POSITION0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.x + u_xlat11;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.z + u_xlat11;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.w + u_xlat11;
    u_xlat11 = (-u_xlat11) + (-_ProjectionParams.y);
    u_xlat11 = u_xlat11 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = _FadeDistance * u_xlat2.x + 0.100000001;
    u_xlat11 = u_xlat11 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat11 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat11) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
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
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb5 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb5) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
ivec2 u_xlati5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
bvec2 u_xlatb18;
float u_xlat27;
float u_xlat28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat28 = u_xlat10_6.x * _SPNoiseScaler;
    u_xlat28 = u_xlat28 * 1.99000001 + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat4.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_7.xyz;
    u_xlat27 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat27) * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat27 = u_xlat27 * 1.70000005 + (-u_xlat28);
    u_xlat27 = u_xlat27 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat16_7.xyz = (u_xlati5.y != 0) ? u_xlat4.xyz : u_xlat6.xyz;
    u_xlat27 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati5.x != 0) ? u_xlat16_7.xyz : u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat27 = (-u_xlat27) + 1.00100005;
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _RGShininess;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _RGScale + _RGBias;
    u_xlat16_3.x = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_3.x * _RGRatio;
    u_xlat10.xyz = vec3(u_xlat27) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat10.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
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
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat11;
    u_xlat11 = u_xlat11 * in_POSITION0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.x + u_xlat11;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.z + u_xlat11;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.w + u_xlat11;
    u_xlat11 = (-u_xlat11) + (-_ProjectionParams.y);
    u_xlat11 = u_xlat11 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = _FadeDistance * u_xlat2.x + 0.100000001;
    u_xlat11 = u_xlat11 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat11 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat11) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
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
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb5 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb5) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
ivec2 u_xlati5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
bvec2 u_xlatb18;
float u_xlat27;
float u_xlat28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat28 = u_xlat10_6.x * _SPNoiseScaler;
    u_xlat28 = u_xlat28 * 1.99000001 + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat4.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_7.xyz;
    u_xlat27 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat27) * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat27 = u_xlat27 * 1.70000005 + (-u_xlat28);
    u_xlat27 = u_xlat27 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat16_7.xyz = (u_xlati5.y != 0) ? u_xlat4.xyz : u_xlat6.xyz;
    u_xlat27 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati5.x != 0) ? u_xlat16_7.xyz : u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat27 = (-u_xlat27) + 1.00100005;
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _RGShininess;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _RGScale + _RGBias;
    u_xlat16_3.x = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_3.x * _RGRatio;
    u_xlat10.xyz = vec3(u_xlat27) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat10.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	float _Opaqueness;
uniform 	mediump vec4 _MainTex_ST;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	float _Shininess;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD3;
out highp vec3 vs_TEXCOORD7;
out highp vec3 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
mediump float u_xlat16_4;
float u_xlat5;
bool u_xlatb5;
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
    u_xlat11 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat11;
    u_xlat11 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat11;
    u_xlat11 = u_xlat11 * in_POSITION0.y;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.x + u_xlat11;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.z + u_xlat11;
    u_xlat2.x = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat2.x;
    u_xlat2.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat2.x;
    u_xlat11 = u_xlat2.x * in_POSITION0.w + u_xlat11;
    u_xlat11 = (-u_xlat11) + (-_ProjectionParams.y);
    u_xlat11 = u_xlat11 + (-_FadeOffset);
    u_xlat2.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat2.x = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = (-u_xlat2.x) + 1.0;
    u_xlat2.x = _FadeDistance * u_xlat2.x + 0.100000001;
    u_xlat11 = u_xlat11 / u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
#else
    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
#endif
    vs_COLOR0.w = u_xlat11 * _Opaqueness;
    vs_COLOR0.xyz = vec3(0.0, 0.0, 0.0);
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
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat11) + u_xlat0.xyz;
    vs_TEXCOORD5.xyz = u_xlat0.xyz;
    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat0.xyz);
    vs_TEXCOORD4.xyz = u_xlat2.xyz;
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
    vs_TEXCOORD6.w = u_xlat1.w;
    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb5 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD6.z = (u_xlatb5) ? 1.0 : u_xlat0.x;
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
uniform 	mediump vec4 _EnvColor;
uniform 	float _SpecMulti;
uniform 	mediump float _BloomFactor;
uniform 	mediump vec3 _LightColor0;
uniform 	mediump float _Emission;
uniform 	mediump vec4 _EmissionColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Ramp;
uniform lowp sampler2D _SpecRamp;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD3;
in highp vec3 vs_TEXCOORD7;
in highp vec3 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
lowp vec4 u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat5;
lowp vec3 u_xlat10_5;
ivec2 u_xlati5;
vec3 u_xlat6;
lowp vec3 u_xlat10_6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
vec3 u_xlat10;
bvec2 u_xlatb18;
float u_xlat27;
float u_xlat28;
void main()
{
	ImmCB_0_0_0[0] = vec4(1.0, 0.0, 0.0, 0.0);
	ImmCB_0_0_0[1] = vec4(0.0, 1.0, 0.0, 0.0);
	ImmCB_0_0_0[2] = vec4(0.0, 0.0, 1.0, 0.0);
	ImmCB_0_0_0[3] = vec4(0.0, 0.0, 0.0, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(vs_TEXCOORD6.z<0.949999988);
#else
    u_xlatb0 = vs_TEXCOORD6.z<0.949999988;
#endif
    if(u_xlatb0){
        u_xlat0.xy = vs_TEXCOORD6.yx / vs_TEXCOORD6.ww;
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
        u_xlat0.x = vs_TEXCOORD6.z * 17.0 + (-u_xlat0.x);
        u_xlat0.x = u_xlat0.x + 0.99000001;
        u_xlat0.x = floor(u_xlat0.x);
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlati0 = int(u_xlat0.x);
        if((u_xlati0)==0){discard;}
    //ENDIF
    }
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat10_1.xyz = texture(_Ramp, vs_TEXCOORD1.xy).xyz;
    u_xlat10_2.xyz = texture(_SpecRamp, vs_TEXCOORD2.xy).xyz;
    u_xlat2.xyz = u_xlat10_2.xyz * vec3(vec3(_SpecMulti, _SpecMulti, _SpecMulti)) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    u_xlat16_3.xyz = u_xlat10_1.xyz * u_xlat16_3.xyz;
    u_xlat16_3.xyz = vec3(u_xlat16_3.x * _LightColor0.xxyz.y, u_xlat16_3.y * _LightColor0.xxyz.z, u_xlat16_3.z * float(_LightColor0.z));
    u_xlat0.xyz = _Color.xyz * _EnvColor.xyz;
    u_xlat1.xyz = vec3(_Emission) * _EmissionColor.xyz + (-u_xlat0.xyz);
    u_xlat0.xyz = u_xlat10_0.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat16_3.xyz;
    u_xlat27 = dot(vs_TEXCOORD4.xyz, vs_TEXCOORD4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * vs_TEXCOORD4.xyz;
    u_xlat4.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat10_5.xyz = texture(_SPTex, vs_TEXCOORD3.xy).xyz;
    u_xlat10_6.xyz = texture(_SPNoiseTex, vs_TEXCOORD3.zw).xyz;
    u_xlat28 = u_xlat10_6.x * _SPNoiseScaler;
    u_xlat28 = u_xlat28 * 1.99000001 + -1.0;
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + (-_WorldSpaceCameraPos.xyz);
    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat6.xyz = u_xlat10_6.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat27) + u_xlat6.xyz;
    u_xlat4.xyz = u_xlat4.xyz + _SPCubeMapOffset.xyz;
    u_xlat27 = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat27 = u_xlat27 + u_xlat27;
    u_xlat4.xyz = u_xlat2.xyz * (-vec3(u_xlat27)) + u_xlat4.xyz;
    u_xlat10_4.xyz = texture(_SPCubeMap, u_xlat4.xyz).xyz;
    u_xlat16_7.xyz = u_xlat10_5.xyz * _SPOldColor.xyz;
    u_xlat16_8.xyz = u_xlat10_4.xyz * _SPCubeMapColor.xyz;
    u_xlat4.xyz = u_xlat16_8.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_7.xyz);
    u_xlat4.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat4.xyz + u_xlat16_7.xyz;
    u_xlat27 = _SPNoiseScaler * _SPTransition;
    u_xlat5.xy = vec2(u_xlat27) * vec2(1.70000005, 1.5) + (-vec2(u_xlat28));
    u_xlat5.xy = u_xlat5.xy + vec2(1.0, 1.0);
    u_xlat5.xy = floor(u_xlat5.xy);
    u_xlat5.xy = max(u_xlat5.xy, vec2(0.0, 0.0));
    u_xlati5.xy = ivec2(u_xlat5.xy);
    u_xlat27 = u_xlat27 * 1.70000005 + (-u_xlat28);
    u_xlat27 = u_xlat27 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat27 = min(max(u_xlat27, 0.0), 1.0);
#else
    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
#endif
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat4.xyz);
    u_xlat6.xyz = vec3(u_xlat27) * u_xlat6.xyz + u_xlat4.xyz;
    u_xlat16_7.xyz = (u_xlati5.y != 0) ? u_xlat4.xyz : u_xlat6.xyz;
    u_xlat27 = (u_xlati5.x != 0) ? _SPIntensity : 0.0;
    u_xlat16_7.xyz = (u_xlati5.x != 0) ? u_xlat16_7.xyz : u_xlat4.xyz;
    u_xlat0.xyz = (-u_xlat16_3.xyz) * u_xlat0.xyz + u_xlat16_7.xyz;
    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat27 = dot(vs_TEXCOORD5.xyz, vs_TEXCOORD5.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat1.xyz = vec3(u_xlat27) * vs_TEXCOORD5.xyz;
    u_xlat27 = dot(u_xlat1.xyz, u_xlat2.xyz);
    u_xlat27 = (-u_xlat27) + 1.00100005;
    u_xlat27 = max(u_xlat27, 0.00100000005);
    u_xlat27 = min(u_xlat27, 1.0);
    u_xlat27 = log2(u_xlat27);
    u_xlat27 = u_xlat27 * _RGShininess;
    u_xlat27 = exp2(u_xlat27);
    u_xlat27 = u_xlat27 * _RGScale + _RGBias;
    u_xlat16_3.x = u_xlat27;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat16_3.x * _RGRatio;
    u_xlat10.xyz = vec3(u_xlat27) * _RGColor.xyz + (-u_xlat0.xyz);
    SV_Target0.xyz = u_xlat1.xxx * u_xlat10.xyz + u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
}
Program "fp" {
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
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
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
}
}
 Pass {
  Name "OUTLINE"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Geometry" }
  Cull Front
  GpuProgramID 130225
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	mediump float _OutlineUseTangent;
uniform 	mediump float _Opaqueness;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat0.xy = vec2(u_xlat8) * u_xlat0.xy;
    u_xlat4.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat4.xy;
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
    u_xlat0.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _FadeDistance * u_xlat0.x + 0.100000001;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * in_POSITION0.y;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.x + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.z + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.w + u_xlat4.x;
    u_xlat4.x = (-u_xlat4.x) + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x + (-_FadeOffset);
    u_xlat0.x = u_xlat4.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x * _Opaqueness;
    vs_COLOR0.w = u_xlat16_3 * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat4.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb4 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD0.z = (u_xlatb4) ? 1.0 : u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
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
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	mediump float _OutlineUseTangent;
uniform 	mediump float _Opaqueness;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat0.xy = vec2(u_xlat8) * u_xlat0.xy;
    u_xlat4.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat4.xy;
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
    u_xlat0.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _FadeDistance * u_xlat0.x + 0.100000001;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * in_POSITION0.y;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.x + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.z + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.w + u_xlat4.x;
    u_xlat4.x = (-u_xlat4.x) + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x + (-_FadeOffset);
    u_xlat0.x = u_xlat4.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x * _Opaqueness;
    vs_COLOR0.w = u_xlat16_3 * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat4.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb4 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD0.z = (u_xlatb4) ? 1.0 : u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
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
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	mediump float _OutlineUseTangent;
uniform 	mediump float _Opaqueness;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat0.xy = vec2(u_xlat8) * u_xlat0.xy;
    u_xlat4.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat4.xy;
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
    u_xlat0.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _FadeDistance * u_xlat0.x + 0.100000001;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * in_POSITION0.y;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.x + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.z + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.w + u_xlat4.x;
    u_xlat4.x = (-u_xlat4.x) + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x + (-_FadeOffset);
    u_xlat0.x = u_xlat4.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x * _Opaqueness;
    vs_COLOR0.w = u_xlat16_3 * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat4.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb4 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD0.z = (u_xlatb4) ? 1.0 : u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
vec4 ImmCB_0_0_0[4];
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4_DITHERMATRIX[4];
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
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
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	mediump float _OutlineUseTangent;
uniform 	mediump float _Opaqueness;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat0.xy = vec2(u_xlat8) * u_xlat0.xy;
    u_xlat4.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat4.xy;
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
    u_xlat0.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _FadeDistance * u_xlat0.x + 0.100000001;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * in_POSITION0.y;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.x + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.z + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.w + u_xlat4.x;
    u_xlat4.x = (-u_xlat4.x) + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x + (-_FadeOffset);
    u_xlat0.x = u_xlat4.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x * _Opaqueness;
    vs_COLOR0.w = u_xlat16_3 * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat4.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb4 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD0.z = (u_xlatb4) ? 1.0 : u_xlat0.x;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4.x = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat12 * 0.25 + u_xlat4.x;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
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
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	mediump float _OutlineUseTangent;
uniform 	mediump float _Opaqueness;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat0.xy = vec2(u_xlat8) * u_xlat0.xy;
    u_xlat4.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat4.xy;
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
    u_xlat0.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _FadeDistance * u_xlat0.x + 0.100000001;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * in_POSITION0.y;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.x + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.z + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.w + u_xlat4.x;
    u_xlat4.x = (-u_xlat4.x) + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x + (-_FadeOffset);
    u_xlat0.x = u_xlat4.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x * _Opaqueness;
    vs_COLOR0.w = u_xlat16_3 * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat4.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb4 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD0.z = (u_xlatb4) ? 1.0 : u_xlat0.x;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4.x = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat12 * 0.25 + u_xlat4.x;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
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
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vec4(0.0, 0.0, 0.0, 0.0);
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _OutlineColor;
uniform 	float _Outline;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
uniform 	mediump float _OutlineUseTangent;
uniform 	mediump float _Opaqueness;
uniform 	float _DitherAlphaLeft;
uniform 	float _DitherAlphaRight;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump float u_xlat16_3;
vec2 u_xlat4;
bool u_xlatb4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_OutlineUseTangent);
#endif
    u_xlat1.xyz = (bool(u_xlatb12)) ? in_TANGENT0.xyz : in_NORMAL0.xyz;
    u_xlat0.z = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
    u_xlat0.x = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat2.xyz;
    u_xlat0.y = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat0.xy = vec2(u_xlat8) * u_xlat0.xy;
    u_xlat4.xy = u_xlat0.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * u_xlat0.xx + u_xlat4.xy;
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
    u_xlat0.xy = u_xlat1.xy / u_xlat1.ww;
    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat0.x = (-u_xlat0.x) + 1.0;
    u_xlat0.x = _FadeDistance * u_xlat0.x + 0.100000001;
    u_xlat4.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat4.x;
    u_xlat4.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat4.x;
    u_xlat4.x = u_xlat4.x * in_POSITION0.y;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.x + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.z + u_xlat4.x;
    u_xlat8 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat8;
    u_xlat8 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat8;
    u_xlat4.x = u_xlat8 * in_POSITION0.w + u_xlat4.x;
    u_xlat4.x = (-u_xlat4.x) + (-_ProjectionParams.y);
    u_xlat4.x = u_xlat4.x + (-_FadeOffset);
    u_xlat0.x = u_xlat4.x / u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3 = u_xlat0.x * _Opaqueness;
    vs_COLOR0.w = u_xlat16_3 * _OutlineColor.w;
    vs_COLOR0.xyz = _OutlineColor.xyz;
    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
    u_xlat4.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat0.w = u_xlat4.x * 0.5;
    vs_TEXCOORD0.xy = u_xlat0.zz + u_xlat0.xw;
    vs_TEXCOORD0.w = u_xlat1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.5<in_COLOR0.x);
#else
    u_xlatb0 = 0.5<in_COLOR0.x;
#endif
    u_xlat0.x = (u_xlatb0) ? _DitherAlphaLeft : _DitherAlphaRight;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(in_COLOR0.x<0.100000001);
#else
    u_xlatb4 = in_COLOR0.x<0.100000001;
#endif
    vs_TEXCOORD0.z = (u_xlatb4) ? 1.0 : u_xlat0.x;
    u_xlat0 = in_POSITION0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat4.x = u_xlat0.w + u_xlat0.y;
    u_xlat12 = u_xlat0.x * in_POSITION0.x;
    u_xlat1.x = u_xlat0.z * u_xlat0.z + u_xlat0.x;
    u_xlat1.y = u_xlat12 * 0.25 + u_xlat4.x;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
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
uniform lowp sampler2D _SPNoiseTex;
in highp vec4 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp float u_xlat10_0;
int u_xlati0;
uvec2 u_xlatu0;
bool u_xlatb0;
vec4 u_xlat1;
float u_xlat2;
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
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0.x = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0.x = u_xlat0.x * 1.99000001 + -1.0;
    u_xlat2 = _SPNoiseScaler * _SPTransition;
    u_xlat0.x = u_xlat2 * 1.70000005 + (-u_xlat0.x);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat16_0 = (int(u_xlati0) != 0) ? _SPOutlineColor : vec4(0.0, 0.0, 0.0, 0.0);
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