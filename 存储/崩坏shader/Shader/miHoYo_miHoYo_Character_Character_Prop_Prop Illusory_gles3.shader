//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop Illusory" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 0.25
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor (lerp factor between original and emission color)", Range(0, 1)) = 0
_EmissionFactorFromTexToggle ("Emission Factor From Tex Toggle", Range(0, 1)) = 0
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_ClipPlane ("Clip Plane (Model Space)", Vector) = (0,0,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
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
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 42532
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_6) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _MainColor.xyz;
    SV_Target0.w = vs_COLOR1.y;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_6) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _MainColor.xyz;
    SV_Target0.w = vs_COLOR1.y;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
bvec2 u_xlatb2;
vec4 u_xlat3;
mediump float u_xlat16_3;
vec4 u_xlat4;
mediump float u_xlat16_5;
vec3 u_xlat6;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat6.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat6.x;
    u_xlat6.x = u_xlat6.x + (-_ClipPlane.w);
    u_xlat6.xyz = (-u_xlat6.xxx) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat6.xyz = (int(u_xlati0) != 0) ? in_POSITION0.xyz : u_xlat6.xyz;
    u_xlat1 = u_xlat6.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat6.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat6.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat6.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat6.xy;
    u_xlat6.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb2.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb2.y) ? u_xlat6.xy : vec2(0.0, 0.0);
    u_xlat6.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat6.xyz;
    u_xlat13 = dot(u_xlat6.xyz, u_xlat6.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat13);
    vs_TEXCOORD1.xyz = u_xlat6.xyz;
    u_xlat16_3 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat6.x = u_xlat16_3 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat6.x;
    u_xlat3 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat3;
    vs_TEXCOORD2.xyz = u_xlat3.xyz / u_xlat3.www;
    u_xlat6.x = u_xlat1.y * _ProjectionParams.x;
    u_xlat4.w = u_xlat6.x * 0.5;
    u_xlat4.xz = u_xlat1.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb2.x ? u_xlat1.w : float(0.0);
    u_xlat6.xy = u_xlat4.zz + u_xlat4.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat6.xy, vec2(u_xlatb2.xx));
    vs_TEXCOORD3.z = u_xlatb2.x ? _DitherAlpha : float(0.0);
    u_xlat6.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat6.x;
    u_xlat6.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat6.x;
    u_xlat6.x = u_xlat6.x * in_POSITION0.y;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.x + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.z + u_xlat6.x;
    u_xlat12 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat12;
    u_xlat12 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat12;
    u_xlat6.x = u_xlat12 * in_POSITION0.w + u_xlat6.x;
    u_xlat6.x = (-u_xlat6.x) + (-_ProjectionParams.y);
    u_xlat6.x = u_xlat6.x + (-_FadeOffset);
    u_xlat6.x = u_xlat6.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb12 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_5 = (u_xlatb12) ? u_xlat6.x : 1.0;
    u_xlat6.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_5 : u_xlat6.x;
    u_xlat0 = u_xlat0 * u_xlat16_5;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump float u_xlat16_6;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_6 = u_xlat10_0.w + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vec3(_EmissionScaler) + (-u_xlat10_0.xyz);
    u_xlat16_1.xyz = vec3(u_xlat16_6) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _MainColor.xyz;
    SV_Target0.w = vs_COLOR1.y;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat9;
ivec2 u_xlati9;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat6.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat16_2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_2.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat15 = _SPNoiseScaler * _SPTransition;
    u_xlat4 = u_xlat15 * 1.70000005 + (-u_xlat1.x);
    u_xlat9.xy = vec2(u_xlat15) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat9.xy = u_xlat9.xy + vec2(1.0, 1.0);
    u_xlat9.xy = floor(u_xlat9.xy);
    u_xlat9.xy = max(u_xlat9.xy, vec2(0.0, 0.0));
    u_xlati9.xy = ivec2(u_xlat9.xy);
    u_xlat15 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati9.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati9.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.x = u_xlat10_1.w + (-_EmissionFactor);
    u_xlat16_0.x = _EmissionFactorFromTexToggle * u_xlat16_0.x + _EmissionFactor;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(_EmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) * _MainColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _MainColor.xyz;
    u_xlat1.x = (u_xlati9.x != 0) ? _SPIntensity : 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.x = (-vs_COLOR1.y) + _SPTransitionBloomFactor;
    u_xlat0.x = u_xlat15 * u_xlat0.x + vs_COLOR1.y;
    u_xlat16_2.x = (u_xlati9.y != 0) ? vs_COLOR1.y : u_xlat0.x;
    SV_Target0.w = (u_xlati9.x != 0) ? u_xlat16_2.x : vs_COLOR1.y;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat9;
ivec2 u_xlati9;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat6.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat16_2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_2.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat15 = _SPNoiseScaler * _SPTransition;
    u_xlat4 = u_xlat15 * 1.70000005 + (-u_xlat1.x);
    u_xlat9.xy = vec2(u_xlat15) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat9.xy = u_xlat9.xy + vec2(1.0, 1.0);
    u_xlat9.xy = floor(u_xlat9.xy);
    u_xlat9.xy = max(u_xlat9.xy, vec2(0.0, 0.0));
    u_xlati9.xy = ivec2(u_xlat9.xy);
    u_xlat15 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati9.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati9.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.x = u_xlat10_1.w + (-_EmissionFactor);
    u_xlat16_0.x = _EmissionFactorFromTexToggle * u_xlat16_0.x + _EmissionFactor;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(_EmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) * _MainColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _MainColor.xyz;
    u_xlat1.x = (u_xlati9.x != 0) ? _SPIntensity : 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.x = (-vs_COLOR1.y) + _SPTransitionBloomFactor;
    u_xlat0.x = u_xlat15 * u_xlat0.x + vs_COLOR1.y;
    u_xlat16_2.x = (u_xlati9.y != 0) ? vs_COLOR1.y : u_xlat0.x;
    SV_Target0.w = (u_xlati9.x != 0) ? u_xlat16_2.x : vs_COLOR1.y;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPTex_ST;
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _MainTex_ST;
uniform 	mediump float _Opaqueness;
uniform 	vec4 _ClipPlane;
uniform 	mediump float _UseCameraFade;
uniform 	mediump float _FadeDistance;
uniform 	mediump float _FadeOffset;
uniform 	float _UsingDitherAlpha;
uniform 	float _DitherAlpha;
uniform 	float _UsingBloomMask;
uniform 	vec4 _BloomMaskTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec2 vs_COLOR1;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bvec2 u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_4;
vec4 u_xlat5;
mediump float u_xlat16_6;
vec3 u_xlat7;
float u_xlat14;
bool u_xlatb14;
vec2 u_xlat15;
float u_xlat16;
void main()
{
    u_xlat0 = _ClipPlane.w + -0.00999999978;
    u_xlat7.x = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0 = (-u_xlat0) + u_xlat7.x;
    u_xlat7.x = u_xlat7.x + (-_ClipPlane.w);
    u_xlat1 = (-u_xlat7.xxxx) * _ClipPlane.xyzz + in_POSITION0.xyzz;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat1 = (int(u_xlati0) != 0) ? in_POSITION0.xyzz : u_xlat1;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat1.wwww + u_xlat2;
    u_xlat2 = u_xlat2 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    u_xlat7.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat7.xy;
    u_xlat7.xy = in_TEXCOORD0.xy * _BloomMaskTex_ST.xy + _BloomMaskTex_ST.zw;
    u_xlatb3.xy = notEqual(vec4(0.0, 0.0, 0.0, 0.0), vec4(_UsingDitherAlpha, _UsingBloomMask, _UsingDitherAlpha, _UsingDitherAlpha)).xy;
    vs_TEXCOORD5.xy = (u_xlatb3.y) ? u_xlat7.xy : vec2(0.0, 0.0);
    u_xlat7.xyz = in_NORMAL0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_NORMAL0.xxx + u_xlat7.xyz;
    u_xlat7.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_NORMAL0.zzz + u_xlat7.xyz;
    u_xlat16 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat16 = inversesqrt(u_xlat16);
    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat16);
    vs_TEXCOORD1.xyz = u_xlat7.xyz;
    u_xlat16_4 = dot(u_xlat7.xyz, _WorldSpaceLightPos0.xyz);
    u_xlat7.x = u_xlat16_4 * 0.497500002 + 0.5;
    vs_COLOR1.x = u_xlat7.x;
    u_xlat4 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat4;
    u_xlat4 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat4;
    vs_TEXCOORD2.xyz = u_xlat4.xyz / u_xlat4.www;
    u_xlat7.x = u_xlat2.y * _ProjectionParams.x;
    u_xlat5.w = u_xlat7.x * 0.5;
    u_xlat5.xz = u_xlat2.xw * vec2(0.5, 0.5);
    vs_TEXCOORD3.w = u_xlatb3.x ? u_xlat2.w : float(0.0);
    u_xlat7.xy = u_xlat5.zz + u_xlat5.xw;
    vs_TEXCOORD3.xy = mix(vec2(0.0, 0.0), u_xlat7.xy, vec2(u_xlatb3.xx));
    vs_TEXCOORD3.z = u_xlatb3.x ? _DitherAlpha : float(0.0);
    u_xlat2 = u_xlat1 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat7.x = u_xlat1.x * u_xlat2.x;
    u_xlat14 = u_xlat2.w + u_xlat2.y;
    u_xlat15.x = u_xlat2.z * u_xlat2.z + u_xlat2.x;
    u_xlat15.y = u_xlat7.x * 0.25 + u_xlat14;
    vs_TEXCOORD4.zw = u_xlat15.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD0.xy * _SPTex_ST.xy + _SPTex_ST.zw;
    u_xlat7.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat7.x;
    u_xlat7.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat7.x;
    u_xlat7.x = u_xlat7.x * in_POSITION0.y;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.x + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.z + u_xlat7.x;
    u_xlat14 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat14;
    u_xlat14 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat14;
    u_xlat7.x = u_xlat14 * in_POSITION0.w + u_xlat7.x;
    u_xlat7.x = (-u_xlat7.x) + (-_ProjectionParams.y);
    u_xlat7.x = u_xlat7.x + (-_FadeOffset);
    u_xlat7.x = u_xlat7.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb14 = !!(vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade));
#else
    u_xlatb14 = vec4(0.0, 0.0, 0.0, 0.0)!=vec4(_UseCameraFade);
#endif
    u_xlat16_6 = (u_xlatb14) ? u_xlat7.x : 1.0;
    u_xlat7.x = 0.0;
    u_xlat0 = (u_xlati0 != 0) ? u_xlat16_6 : u_xlat7.x;
    u_xlat0 = u_xlat0 * u_xlat16_6;
    vs_COLOR1.y = u_xlat0 * _Opaqueness;
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
uniform 	float _SPTransitionBloomFactor;
uniform 	vec3 _SPCubeMapOffset;
uniform 	float _SPCubeMapIntensity;
uniform 	float _SPCubeMapNoiseIntensity;
uniform 	float _SPCubeMapBrightness;
uniform 	mediump vec4 _SPOldColor;
uniform 	mediump vec4 _SPCubeMapColor;
uniform 	mediump vec4 _MainColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPTex;
uniform lowp sampler2D _SPNoiseTex;
uniform lowp samplerCube _SPCubeMap;
in mediump vec2 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD4;
in mediump vec2 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat9;
ivec2 u_xlati9;
float u_xlat15;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + (-_WorldSpaceCameraPos.xyz);
    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat15 = inversesqrt(u_xlat15);
    u_xlat10_1.xyz = texture(_SPNoiseTex, vs_TEXCOORD4.zw).xyz;
    u_xlat6.xyz = u_xlat10_1.xyz * vec3(_SPCubeMapNoiseIntensity);
    u_xlat16_2.x = u_xlat10_1.x * 1.99000001;
    u_xlat1.x = u_xlat16_2.x * _SPNoiseScaler + -1.0;
    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat15) + u_xlat6.xyz;
    u_xlat0.xyz = u_xlat0.xyz + _SPCubeMapOffset.xyz;
    u_xlat16_2.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat16_2.xxx * vs_TEXCOORD1.xyz;
    u_xlat15 = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat15 = u_xlat15 + u_xlat15;
    u_xlat0.xyz = u_xlat16_2.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat10_0.xyz = texture(_SPCubeMap, u_xlat0.xyz).xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * _SPCubeMapColor.xyz;
    u_xlat10_0.xyz = texture(_SPTex, vs_TEXCOORD4.xy).xyz;
    u_xlat16_3.xyz = u_xlat10_0.xyz * _SPOldColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(vec3(_SPCubeMapBrightness, _SPCubeMapBrightness, _SPCubeMapBrightness)) + (-u_xlat16_3.xyz);
    u_xlat0.xyz = vec3(vec3(_SPCubeMapIntensity, _SPCubeMapIntensity, _SPCubeMapIntensity)) * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat6.xyz = _SPTransitionColor.xyz * vec3(_SPTransitionEmissionScaler) + (-u_xlat0.xyz);
    u_xlat15 = _SPNoiseScaler * _SPTransition;
    u_xlat4 = u_xlat15 * 1.70000005 + (-u_xlat1.x);
    u_xlat9.xy = vec2(u_xlat15) * vec2(1.70000005, 1.5) + (-u_xlat1.xx);
    u_xlat9.xy = u_xlat9.xy + vec2(1.0, 1.0);
    u_xlat9.xy = floor(u_xlat9.xy);
    u_xlat9.xy = max(u_xlat9.xy, vec2(0.0, 0.0));
    u_xlati9.xy = ivec2(u_xlat9.xy);
    u_xlat15 = u_xlat4 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
#else
    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat15) * u_xlat6.xyz + u_xlat0.xyz;
    u_xlat16_2.xyz = (u_xlati9.y != 0) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat16_2.xyz = (u_xlati9.x != 0) ? u_xlat16_2.xyz : u_xlat0.xyz;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0.x = u_xlat10_1.w + (-_EmissionFactor);
    u_xlat16_0.x = _EmissionFactorFromTexToggle * u_xlat16_0.x + _EmissionFactor;
    u_xlat16_3.xyz = u_xlat10_1.xyz * vec3(_EmissionScaler) + (-u_xlat10_1.xyz);
    u_xlat16_3.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz + u_xlat10_1.xyz;
    u_xlat16_0.xyz = (-u_xlat16_3.xyz) * _MainColor.xyz + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat16_3.xyz * _MainColor.xyz;
    u_xlat1.x = (u_xlati9.x != 0) ? _SPIntensity : 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.x = (-vs_COLOR1.y) + _SPTransitionBloomFactor;
    u_xlat0.x = u_xlat15 * u_xlat0.x + vs_COLOR1.y;
    u_xlat16_2.x = (u_xlati9.y != 0) ? vs_COLOR1.y : u_xlat0.x;
    SV_Target0.w = (u_xlati9.x != 0) ? u_xlat16_2.x : vs_COLOR1.y;
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
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 90889
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    vs_TEXCOORD0.z = u_xlat0.w;
    u_xlat0 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump float u_xlat16_0;
lowp float u_xlat10_0;
mediump float u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_0 = u_xlat10_0 + (-_EmissionFactor);
    u_xlat16_0 = _EmissionFactorFromTexToggle * u_xlat16_0 + _EmissionFactor;
    u_xlat16_1 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_1 = u_xlat16_0 * u_xlat16_1 + _BloomFactor;
    u_xlat0 = u_xlat16_1 * vs_TEXCOORD0.z;
    SV_Target0.w = u_xlat0;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _SPNoiseTex_ST;
uniform 	vec4 _ClipPlane;
in highp vec4 in_POSITION0;
in highp vec4 in_TEXCOORD0;
out highp vec3 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0.x = _ClipPlane.w + -0.00999999978;
    u_xlat3 = dot(in_POSITION0.xyz, _ClipPlane.xyz);
    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
    u_xlat3 = u_xlat3 + (-_ClipPlane.w);
    u_xlat1.xyz = (-vec3(u_xlat3)) * _ClipPlane.xyz + in_POSITION0.xyz;
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlati0 = int(u_xlat0.x);
    u_xlat2.xyz = in_POSITION0.xyz;
    u_xlat2.w = 1.0;
    u_xlat1.w = 0.0;
    u_xlat0 = (int(u_xlati0) != 0) ? u_xlat2 : u_xlat1;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    vs_TEXCOORD0.z = u_xlat0.w;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1 = u_xlat0.xyzz * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    vs_TEXCOORD1.xy = u_xlat1.xy * _SPNoiseTex_ST.xy + _SPNoiseTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _SPNoiseScaler;
uniform 	float _SPTransition;
uniform 	mediump float _SPOpaqueness;
uniform 	float _SPTransitionBloomFactor;
uniform 	mediump float _BloomFactor;
uniform 	mediump float _EmissionFactor;
uniform 	mediump float _EmissionFactorFromTexToggle;
uniform 	mediump float _EmissionBloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SPNoiseTex;
in highp vec3 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
mediump float u_xlat16_2;
vec3 u_xlat3;
ivec3 u_xlati3;
bvec2 u_xlatb3;
float u_xlat6;
mediump float u_xlat16_6;
lowp float u_xlat10_6;
void main()
{
    u_xlat10_0 = texture(_SPNoiseTex, vs_TEXCOORD1.xy).x;
    u_xlat0 = u_xlat10_0 * _SPNoiseScaler;
    u_xlat0 = u_xlat0 * 1.99000001 + -1.0;
    u_xlat3.x = _SPNoiseScaler * _SPTransition;
    u_xlat6 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat6 = u_xlat6 + 1.0;
    u_xlat6 = floor(u_xlat6);
    u_xlat6 = max(u_xlat6, 0.0);
    u_xlati3.y = int(u_xlat6);
    u_xlat1.xy = (-u_xlat3.xx) * vec2(1.70000005, 1.5) + vec2(u_xlat0);
    u_xlat0 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat0 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat3.xz = u_xlat1.xy + vec2(1.0, 1.0);
    u_xlat3.xz = floor(u_xlat3.xz);
    u_xlat3.xz = max(u_xlat3.xz, vec2(0.0, 0.0));
    u_xlati3.xz = ivec2(u_xlat3.xz);
    u_xlatb3.xy = equal(u_xlati3.xyxx, ivec4(0, 0, 0, 0)).xy;
    u_xlatb3.x = u_xlatb3.x && u_xlatb3.y;
    u_xlat10_6 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat16_6 = u_xlat10_6 + (-_EmissionFactor);
    u_xlat16_6 = _EmissionFactorFromTexToggle * u_xlat16_6 + _EmissionFactor;
    u_xlat16_2 = (-_BloomFactor) + _EmissionBloomFactor;
    u_xlat16_2 = u_xlat16_6 * u_xlat16_2 + _BloomFactor;
    u_xlat6 = u_xlat16_2 * vs_TEXCOORD0.z;
    u_xlat1.x = (-u_xlat16_2) * vs_TEXCOORD0.z + _SPTransitionBloomFactor;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat6;
    u_xlat16_2 = u_xlat6 * _SPOpaqueness;
    u_xlat16_2 = (u_xlati3.z != 0) ? u_xlat6 : u_xlat16_2;
    SV_Target0.w = (u_xlatb3.x) ? u_xlat0 : u_xlat16_2;
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
Fallback "Diffuse"
CustomEditor "MoleMole.PropShaderEditorBase"
}