//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Sphere Shield" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_RingTex ("Ring Texture 1", 2D) = "black" { }
_RingColor ("Ring Color", Color) = (1,1,1,1)
_RingUScale ("Ring U Scale", Float) = 1
_RingVScale ("Ring V Scale", Float) = 1
_RingUFadeWidth ("Ring U Fade Width", Float) = 0
_RingCrossLightIntensity ("Ring Cross Light Intensity", Float) = 50
_RingCrossLightShininess ("Ring Cross Light Shininess", Float) = 2
_RingEulerAngles1 ("Ring Euler Angles 1", Vector) = (0,0,0,0)
_RingEulerAngles2 ("Ring Euler Angles 2", Vector) = (0,0,0,0)
_RingEulerAngles3 ("Ring Euler Angles 3", Vector) = (0,0,0,0)
_BloomFactor ("Bloom Factor", Float) = 1
_FresnelParams ("Fresnel", Vector) = (1,0,0,0)
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_CellShrink ("Cell Shrink", Float) = 0
_CellRimShininess ("Cell Rim Shininess", Float) = 8
_CellRimIntensity ("Cell Rim Intensity", Float) = 0.4
_HitPosition ("Hit Position (local space)", Vector) = (0,0,0,0)
_HitDistRange ("Hit Dist Range", Float) = 0
_HitDistSmoothRange ("Hit Dist Smooth Range", Float) = 0
_HitAnmStartTime ("Hit Animation Start Time", Float) = 0
_HitAnmEndTime ("Hit Animation End Time", Float) = 0
_BandPosition ("Band Position (rotate dir and angle)", Vector) = (1,1,0,1.57)
_BandWidth ("Band Width", Float) = 0
_BandIntensity ("Band Intensity", Float) = 0
_Params ("Params", Vector) = (0,0,0,0)
_Params2 ("Params2", Vector) = (0,0,0,0)
_Params3 ("Params3", Vector) = (0,0,0,0)
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 32066
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _RingUScale;
uniform 	mediump float _RingVScale;
uniform 	mediump float _RingUFadeWidth;
uniform 	mediump vec4 _RingEulerAngles1;
uniform 	mediump vec4 _RingEulerAngles2;
uniform 	mediump vec4 _RingEulerAngles3;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
bool u_xlatb17;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat8.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb16 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat24 = u_xlat8.x * u_xlat0.x;
    u_xlat24 = u_xlat24 * -2.0 + 3.14159274;
    u_xlat16 = u_xlatb16 ? u_xlat24 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat16;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_10 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_10 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_18.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_18.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat8.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_10 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_10 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_10 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_10 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_18.xy;
    u_xlat16_0 = u_xlat16_18.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = (-u_xlat1.xyz);
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_18.yyyy + u_xlat16_0;
    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
    u_xlat16_2.xyz = sin(_RingEulerAngles1.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles1.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_26 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_19 = min(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_19;
    u_xlat16_19 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_19 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_19 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_26));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_26);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_26);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    vs_TEXCOORD4.x = u_xlat16_10 * _RingUScale + _RingEulerAngles1.w;
    u_xlat16_10 = -abs(u_xlat16_10) + 0.5;
    u_xlat16_26 = float(1.0) / _RingUFadeWidth;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD4.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD4.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.y = min(max(vs_TEXCOORD4.y, 0.0), 1.0);
#else
    vs_TEXCOORD4.y = clamp(vs_TEXCOORD4.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles2.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles2.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD5.x = u_xlat16_10 * _RingUScale + _RingEulerAngles2.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD5.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD5.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.y = min(max(vs_TEXCOORD5.y, 0.0), 1.0);
#else
    vs_TEXCOORD5.y = clamp(vs_TEXCOORD5.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles3.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles3.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD6.x = u_xlat16_10 * _RingUScale + _RingEulerAngles3.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD6.z = u_xlat16_10 * u_xlat16_26;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat1.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat9 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb17 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat9 = sqrt(u_xlat9);
    u_xlat25 = u_xlat9 * u_xlat1.x;
    u_xlat25 = u_xlat25 * -2.0 + 3.14159274;
    u_xlat17 = u_xlatb17 ? u_xlat25 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat17;
    u_xlat16_2.x = u_xlat1.x * 0.318309993 + -0.5;
    vs_TEXCOORD6.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD6.y = min(max(vs_TEXCOORD6.y, 0.0), 1.0);
#else
    vs_TEXCOORD6.y = clamp(vs_TEXCOORD6.y, 0.0, 1.0);
#endif
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RingColor;
uniform 	mediump float _RingCrossLightIntensity;
uniform 	mediump float _RingCrossLightShininess;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
uniform lowp sampler2D _RingTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_5.x = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_5.x = u_xlat16_1 * _CellRimIntensity + u_xlat16_5.x;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_5.x = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_5.x;
    u_xlat16_9 = log2(vs_TEXCOORD0.x);
    u_xlat16_9 = u_xlat16_9 * _CellRimShininess;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_5.x + u_xlat16_1;
    u_xlat10_0.xy = texture(_RingTex, vs_TEXCOORD5.xy).xy;
    u_xlat10_8.xy = texture(_RingTex, vs_TEXCOORD6.xy).xy;
    u_xlat16_5.x = u_xlat10_8.y * u_xlat10_0.y;
    u_xlat10_2.xy = texture(_RingTex, vs_TEXCOORD4.xy).xy;
    u_xlat16_9 = u_xlat10_2.y * u_xlat10_0.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_0.y * u_xlat10_2.y;
    u_xlat16_3.x = u_xlat10_0.x * vs_TEXCOORD5.z;
    u_xlat16_3.x = u_xlat10_2.x * vs_TEXCOORD4.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_8.x * vs_TEXCOORD6.z + u_xlat16_3.x;
    u_xlat16_5.x = (-u_xlat16_13) * u_xlat16_5.x + u_xlat16_9;
    u_xlat16_9 = u_xlat10_8.y * u_xlat10_2.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_8.y * u_xlat10_2.y;
    u_xlat16_5.x = (-u_xlat16_5.x) * u_xlat16_13 + u_xlat16_9;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightShininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightIntensity + u_xlat16_3.x;
    u_xlat16_3.xyz = _RingColor.www * _RingColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz + u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _RingUScale;
uniform 	mediump float _RingVScale;
uniform 	mediump float _RingUFadeWidth;
uniform 	mediump vec4 _RingEulerAngles1;
uniform 	mediump vec4 _RingEulerAngles2;
uniform 	mediump vec4 _RingEulerAngles3;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
bool u_xlatb17;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat8.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb16 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat24 = u_xlat8.x * u_xlat0.x;
    u_xlat24 = u_xlat24 * -2.0 + 3.14159274;
    u_xlat16 = u_xlatb16 ? u_xlat24 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat16;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_10 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_10 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_18.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_18.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat8.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_10 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_10 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_10 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_10 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_18.xy;
    u_xlat16_0 = u_xlat16_18.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = (-u_xlat1.xyz);
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_18.yyyy + u_xlat16_0;
    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
    u_xlat16_2.xyz = sin(_RingEulerAngles1.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles1.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_26 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_19 = min(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_19;
    u_xlat16_19 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_19 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_19 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_26));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_26);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_26);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    vs_TEXCOORD4.x = u_xlat16_10 * _RingUScale + _RingEulerAngles1.w;
    u_xlat16_10 = -abs(u_xlat16_10) + 0.5;
    u_xlat16_26 = float(1.0) / _RingUFadeWidth;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD4.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD4.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.y = min(max(vs_TEXCOORD4.y, 0.0), 1.0);
#else
    vs_TEXCOORD4.y = clamp(vs_TEXCOORD4.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles2.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles2.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD5.x = u_xlat16_10 * _RingUScale + _RingEulerAngles2.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD5.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD5.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.y = min(max(vs_TEXCOORD5.y, 0.0), 1.0);
#else
    vs_TEXCOORD5.y = clamp(vs_TEXCOORD5.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles3.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles3.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD6.x = u_xlat16_10 * _RingUScale + _RingEulerAngles3.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD6.z = u_xlat16_10 * u_xlat16_26;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat1.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat9 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb17 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat9 = sqrt(u_xlat9);
    u_xlat25 = u_xlat9 * u_xlat1.x;
    u_xlat25 = u_xlat25 * -2.0 + 3.14159274;
    u_xlat17 = u_xlatb17 ? u_xlat25 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat17;
    u_xlat16_2.x = u_xlat1.x * 0.318309993 + -0.5;
    vs_TEXCOORD6.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD6.y = min(max(vs_TEXCOORD6.y, 0.0), 1.0);
#else
    vs_TEXCOORD6.y = clamp(vs_TEXCOORD6.y, 0.0, 1.0);
#endif
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RingColor;
uniform 	mediump float _RingCrossLightIntensity;
uniform 	mediump float _RingCrossLightShininess;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
uniform lowp sampler2D _RingTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_5.x = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_5.x = u_xlat16_1 * _CellRimIntensity + u_xlat16_5.x;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_5.x = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_5.x;
    u_xlat16_9 = log2(vs_TEXCOORD0.x);
    u_xlat16_9 = u_xlat16_9 * _CellRimShininess;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_5.x + u_xlat16_1;
    u_xlat10_0.xy = texture(_RingTex, vs_TEXCOORD5.xy).xy;
    u_xlat10_8.xy = texture(_RingTex, vs_TEXCOORD6.xy).xy;
    u_xlat16_5.x = u_xlat10_8.y * u_xlat10_0.y;
    u_xlat10_2.xy = texture(_RingTex, vs_TEXCOORD4.xy).xy;
    u_xlat16_9 = u_xlat10_2.y * u_xlat10_0.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_0.y * u_xlat10_2.y;
    u_xlat16_3.x = u_xlat10_0.x * vs_TEXCOORD5.z;
    u_xlat16_3.x = u_xlat10_2.x * vs_TEXCOORD4.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_8.x * vs_TEXCOORD6.z + u_xlat16_3.x;
    u_xlat16_5.x = (-u_xlat16_13) * u_xlat16_5.x + u_xlat16_9;
    u_xlat16_9 = u_xlat10_8.y * u_xlat10_2.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_8.y * u_xlat10_2.y;
    u_xlat16_5.x = (-u_xlat16_5.x) * u_xlat16_13 + u_xlat16_9;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightShininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightIntensity + u_xlat16_3.x;
    u_xlat16_3.xyz = _RingColor.www * _RingColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz + u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _RingUScale;
uniform 	mediump float _RingVScale;
uniform 	mediump float _RingUFadeWidth;
uniform 	mediump vec4 _RingEulerAngles1;
uniform 	mediump vec4 _RingEulerAngles2;
uniform 	mediump vec4 _RingEulerAngles3;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
bool u_xlatb17;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat8.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb16 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat24 = u_xlat8.x * u_xlat0.x;
    u_xlat24 = u_xlat24 * -2.0 + 3.14159274;
    u_xlat16 = u_xlatb16 ? u_xlat24 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat16;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_10 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_10 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_18.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_18.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat8.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_10 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_10 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_10 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_10 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_18.xy;
    u_xlat16_0 = u_xlat16_18.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = (-u_xlat1.xyz);
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_18.yyyy + u_xlat16_0;
    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
    u_xlat16_2.xyz = sin(_RingEulerAngles1.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles1.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_26 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_19 = min(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_19;
    u_xlat16_19 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_19 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_19 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_26));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_26);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_26);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    vs_TEXCOORD4.x = u_xlat16_10 * _RingUScale + _RingEulerAngles1.w;
    u_xlat16_10 = -abs(u_xlat16_10) + 0.5;
    u_xlat16_26 = float(1.0) / _RingUFadeWidth;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD4.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD4.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.y = min(max(vs_TEXCOORD4.y, 0.0), 1.0);
#else
    vs_TEXCOORD4.y = clamp(vs_TEXCOORD4.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles2.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles2.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD5.x = u_xlat16_10 * _RingUScale + _RingEulerAngles2.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD5.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD5.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.y = min(max(vs_TEXCOORD5.y, 0.0), 1.0);
#else
    vs_TEXCOORD5.y = clamp(vs_TEXCOORD5.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles3.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles3.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD6.x = u_xlat16_10 * _RingUScale + _RingEulerAngles3.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD6.z = u_xlat16_10 * u_xlat16_26;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat1.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat9 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb17 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat9 = sqrt(u_xlat9);
    u_xlat25 = u_xlat9 * u_xlat1.x;
    u_xlat25 = u_xlat25 * -2.0 + 3.14159274;
    u_xlat17 = u_xlatb17 ? u_xlat25 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat17;
    u_xlat16_2.x = u_xlat1.x * 0.318309993 + -0.5;
    vs_TEXCOORD6.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD6.y = min(max(vs_TEXCOORD6.y, 0.0), 1.0);
#else
    vs_TEXCOORD6.y = clamp(vs_TEXCOORD6.y, 0.0, 1.0);
#endif
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RingColor;
uniform 	mediump float _RingCrossLightIntensity;
uniform 	mediump float _RingCrossLightShininess;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
uniform lowp sampler2D _RingTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_5.x = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_5.x = u_xlat16_1 * _CellRimIntensity + u_xlat16_5.x;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_5.x = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_5.x;
    u_xlat16_9 = log2(vs_TEXCOORD0.x);
    u_xlat16_9 = u_xlat16_9 * _CellRimShininess;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_5.x + u_xlat16_1;
    u_xlat10_0.xy = texture(_RingTex, vs_TEXCOORD5.xy).xy;
    u_xlat10_8.xy = texture(_RingTex, vs_TEXCOORD6.xy).xy;
    u_xlat16_5.x = u_xlat10_8.y * u_xlat10_0.y;
    u_xlat10_2.xy = texture(_RingTex, vs_TEXCOORD4.xy).xy;
    u_xlat16_9 = u_xlat10_2.y * u_xlat10_0.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_0.y * u_xlat10_2.y;
    u_xlat16_3.x = u_xlat10_0.x * vs_TEXCOORD5.z;
    u_xlat16_3.x = u_xlat10_2.x * vs_TEXCOORD4.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_8.x * vs_TEXCOORD6.z + u_xlat16_3.x;
    u_xlat16_5.x = (-u_xlat16_13) * u_xlat16_5.x + u_xlat16_9;
    u_xlat16_9 = u_xlat10_8.y * u_xlat10_2.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_8.y * u_xlat10_2.y;
    u_xlat16_5.x = (-u_xlat16_5.x) * u_xlat16_13 + u_xlat16_9;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightShininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightIntensity + u_xlat16_3.x;
    u_xlat16_3.xyz = _RingColor.www * _RingColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz + u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
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
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 130227
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _RingUScale;
uniform 	mediump float _RingVScale;
uniform 	mediump float _RingUFadeWidth;
uniform 	mediump vec4 _RingEulerAngles1;
uniform 	mediump vec4 _RingEulerAngles2;
uniform 	mediump vec4 _RingEulerAngles3;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
bool u_xlatb17;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat8.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb16 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat24 = u_xlat8.x * u_xlat0.x;
    u_xlat24 = u_xlat24 * -2.0 + 3.14159274;
    u_xlat16 = u_xlatb16 ? u_xlat24 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat16;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_10 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_10 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_18.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_18.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat8.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_10 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_10 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_10 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_10 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_18.xy;
    u_xlat16_0 = u_xlat16_18.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_18.yyyy + u_xlat16_0;
    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
    u_xlat16_2.xyz = sin(_RingEulerAngles1.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles1.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_26 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_19 = min(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_19;
    u_xlat16_19 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_19 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_19 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_26));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_26);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_26);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    vs_TEXCOORD4.x = u_xlat16_10 * _RingUScale + _RingEulerAngles1.w;
    u_xlat16_10 = -abs(u_xlat16_10) + 0.5;
    u_xlat16_26 = float(1.0) / _RingUFadeWidth;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD4.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD4.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.y = min(max(vs_TEXCOORD4.y, 0.0), 1.0);
#else
    vs_TEXCOORD4.y = clamp(vs_TEXCOORD4.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles2.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles2.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD5.x = u_xlat16_10 * _RingUScale + _RingEulerAngles2.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD5.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD5.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.y = min(max(vs_TEXCOORD5.y, 0.0), 1.0);
#else
    vs_TEXCOORD5.y = clamp(vs_TEXCOORD5.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles3.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles3.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD6.x = u_xlat16_10 * _RingUScale + _RingEulerAngles3.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD6.z = u_xlat16_10 * u_xlat16_26;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat1.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat9 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb17 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat9 = sqrt(u_xlat9);
    u_xlat25 = u_xlat9 * u_xlat1.x;
    u_xlat25 = u_xlat25 * -2.0 + 3.14159274;
    u_xlat17 = u_xlatb17 ? u_xlat25 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat17;
    u_xlat16_2.x = u_xlat1.x * 0.318309993 + -0.5;
    vs_TEXCOORD6.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD6.y = min(max(vs_TEXCOORD6.y, 0.0), 1.0);
#else
    vs_TEXCOORD6.y = clamp(vs_TEXCOORD6.y, 0.0, 1.0);
#endif
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RingColor;
uniform 	mediump float _RingCrossLightIntensity;
uniform 	mediump float _RingCrossLightShininess;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
uniform lowp sampler2D _RingTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_5.x = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_5.x = u_xlat16_1 * _CellRimIntensity + u_xlat16_5.x;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_5.x = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_5.x;
    u_xlat16_9 = log2(vs_TEXCOORD0.x);
    u_xlat16_9 = u_xlat16_9 * _CellRimShininess;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_5.x + u_xlat16_1;
    u_xlat10_0.xy = texture(_RingTex, vs_TEXCOORD5.xy).xy;
    u_xlat10_8.xy = texture(_RingTex, vs_TEXCOORD6.xy).xy;
    u_xlat16_5.x = u_xlat10_8.y * u_xlat10_0.y;
    u_xlat10_2.xy = texture(_RingTex, vs_TEXCOORD4.xy).xy;
    u_xlat16_9 = u_xlat10_2.y * u_xlat10_0.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_0.y * u_xlat10_2.y;
    u_xlat16_3.x = u_xlat10_0.x * vs_TEXCOORD5.z;
    u_xlat16_3.x = u_xlat10_2.x * vs_TEXCOORD4.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_8.x * vs_TEXCOORD6.z + u_xlat16_3.x;
    u_xlat16_5.x = (-u_xlat16_13) * u_xlat16_5.x + u_xlat16_9;
    u_xlat16_9 = u_xlat10_8.y * u_xlat10_2.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_8.y * u_xlat10_2.y;
    u_xlat16_5.x = (-u_xlat16_5.x) * u_xlat16_13 + u_xlat16_9;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightShininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightIntensity + u_xlat16_3.x;
    u_xlat16_3.xyz = _RingColor.www * _RingColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz + u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _RingUScale;
uniform 	mediump float _RingVScale;
uniform 	mediump float _RingUFadeWidth;
uniform 	mediump vec4 _RingEulerAngles1;
uniform 	mediump vec4 _RingEulerAngles2;
uniform 	mediump vec4 _RingEulerAngles3;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
bool u_xlatb17;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat8.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb16 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat24 = u_xlat8.x * u_xlat0.x;
    u_xlat24 = u_xlat24 * -2.0 + 3.14159274;
    u_xlat16 = u_xlatb16 ? u_xlat24 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat16;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_10 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_10 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_18.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_18.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat8.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_10 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_10 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_10 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_10 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_18.xy;
    u_xlat16_0 = u_xlat16_18.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_18.yyyy + u_xlat16_0;
    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
    u_xlat16_2.xyz = sin(_RingEulerAngles1.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles1.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_26 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_19 = min(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_19;
    u_xlat16_19 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_19 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_19 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_26));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_26);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_26);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    vs_TEXCOORD4.x = u_xlat16_10 * _RingUScale + _RingEulerAngles1.w;
    u_xlat16_10 = -abs(u_xlat16_10) + 0.5;
    u_xlat16_26 = float(1.0) / _RingUFadeWidth;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD4.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD4.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.y = min(max(vs_TEXCOORD4.y, 0.0), 1.0);
#else
    vs_TEXCOORD4.y = clamp(vs_TEXCOORD4.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles2.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles2.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD5.x = u_xlat16_10 * _RingUScale + _RingEulerAngles2.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD5.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD5.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.y = min(max(vs_TEXCOORD5.y, 0.0), 1.0);
#else
    vs_TEXCOORD5.y = clamp(vs_TEXCOORD5.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles3.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles3.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD6.x = u_xlat16_10 * _RingUScale + _RingEulerAngles3.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD6.z = u_xlat16_10 * u_xlat16_26;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat1.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat9 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb17 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat9 = sqrt(u_xlat9);
    u_xlat25 = u_xlat9 * u_xlat1.x;
    u_xlat25 = u_xlat25 * -2.0 + 3.14159274;
    u_xlat17 = u_xlatb17 ? u_xlat25 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat17;
    u_xlat16_2.x = u_xlat1.x * 0.318309993 + -0.5;
    vs_TEXCOORD6.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD6.y = min(max(vs_TEXCOORD6.y, 0.0), 1.0);
#else
    vs_TEXCOORD6.y = clamp(vs_TEXCOORD6.y, 0.0, 1.0);
#endif
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RingColor;
uniform 	mediump float _RingCrossLightIntensity;
uniform 	mediump float _RingCrossLightShininess;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
uniform lowp sampler2D _RingTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_5.x = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_5.x = u_xlat16_1 * _CellRimIntensity + u_xlat16_5.x;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_5.x = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_5.x;
    u_xlat16_9 = log2(vs_TEXCOORD0.x);
    u_xlat16_9 = u_xlat16_9 * _CellRimShininess;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_5.x + u_xlat16_1;
    u_xlat10_0.xy = texture(_RingTex, vs_TEXCOORD5.xy).xy;
    u_xlat10_8.xy = texture(_RingTex, vs_TEXCOORD6.xy).xy;
    u_xlat16_5.x = u_xlat10_8.y * u_xlat10_0.y;
    u_xlat10_2.xy = texture(_RingTex, vs_TEXCOORD4.xy).xy;
    u_xlat16_9 = u_xlat10_2.y * u_xlat10_0.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_0.y * u_xlat10_2.y;
    u_xlat16_3.x = u_xlat10_0.x * vs_TEXCOORD5.z;
    u_xlat16_3.x = u_xlat10_2.x * vs_TEXCOORD4.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_8.x * vs_TEXCOORD6.z + u_xlat16_3.x;
    u_xlat16_5.x = (-u_xlat16_13) * u_xlat16_5.x + u_xlat16_9;
    u_xlat16_9 = u_xlat10_8.y * u_xlat10_2.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_8.y * u_xlat10_2.y;
    u_xlat16_5.x = (-u_xlat16_5.x) * u_xlat16_13 + u_xlat16_9;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightShininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightIntensity + u_xlat16_3.x;
    u_xlat16_3.xyz = _RingColor.www * _RingColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz + u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _RingUScale;
uniform 	mediump float _RingVScale;
uniform 	mediump float _RingUFadeWidth;
uniform 	mediump vec4 _RingEulerAngles1;
uniform 	mediump vec4 _RingEulerAngles2;
uniform 	mediump vec4 _RingEulerAngles3;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out mediump vec3 vs_TEXCOORD6;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
mediump vec3 u_xlat16_6;
float u_xlat7;
bool u_xlatb7;
vec3 u_xlat8;
float u_xlat9;
mediump float u_xlat16_10;
float u_xlat15;
bool u_xlatb15;
float u_xlat16;
bool u_xlatb16;
float u_xlat17;
bool u_xlatb17;
mediump vec2 u_xlat16_18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat24;
float u_xlat25;
mediump float u_xlat16_26;
mediump float u_xlat16_28;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat8.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb16 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat8.x = sqrt(u_xlat8.x);
    u_xlat24 = u_xlat8.x * u_xlat0.x;
    u_xlat24 = u_xlat24 * -2.0 + 3.14159274;
    u_xlat16 = u_xlatb16 ? u_xlat24 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat8.x + u_xlat16;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_10 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_10 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_18.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_18.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat8.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat8.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_10 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_10 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_10) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_10 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_18.x = u_xlat16_10 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_18.xy;
    u_xlat16_0 = u_xlat16_18.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat25 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat25 = inversesqrt(u_xlat25);
    u_xlat1.xyz = vec3(u_xlat25) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_18.yyyy + u_xlat16_0;
    u_xlat1.x = dot(in_POSITION0.xyz, in_POSITION0.xyz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xyz = u_xlat1.xxx * in_POSITION0.xyz;
    u_xlat16_2.xyz = sin(_RingEulerAngles1.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles1.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_26 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_19 = min(abs(u_xlat16_10), abs(u_xlat16_26));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_19;
    u_xlat16_19 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_19 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_19 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_19 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_26));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_26);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_26);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_26);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    vs_TEXCOORD4.x = u_xlat16_10 * _RingUScale + _RingEulerAngles1.w;
    u_xlat16_10 = -abs(u_xlat16_10) + 0.5;
    u_xlat16_26 = float(1.0) / _RingUFadeWidth;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD4.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD4.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD4.y = min(max(vs_TEXCOORD4.y, 0.0), 1.0);
#else
    vs_TEXCOORD4.y = clamp(vs_TEXCOORD4.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles2.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles2.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD5.x = u_xlat16_10 * _RingUScale + _RingEulerAngles2.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD5.z = u_xlat16_10 * u_xlat16_3.x;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat25 = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat25 = u_xlat25 * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb15 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat23 = u_xlat25 * u_xlat7;
    u_xlat23 = u_xlat23 * -2.0 + 3.14159274;
    u_xlat15 = u_xlatb15 ? u_xlat23 : float(0.0);
    u_xlat25 = u_xlat25 * u_xlat7 + u_xlat15;
    u_xlat16_2.x = u_xlat25 * 0.318309993 + -0.5;
    vs_TEXCOORD5.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD5.y = min(max(vs_TEXCOORD5.y, 0.0), 1.0);
#else
    vs_TEXCOORD5.y = clamp(vs_TEXCOORD5.y, 0.0, 1.0);
#endif
    u_xlat16_2.xyz = sin(_RingEulerAngles3.xyz);
    u_xlat16_3.xyz = cos(_RingEulerAngles3.xyz);
    u_xlat16_4.xy = vec2(u_xlat16_2.z * u_xlat16_2.x, u_xlat16_2.y * u_xlat16_2.x);
    u_xlat16_5.xyz = u_xlat16_2.yxz * u_xlat16_3.xzx;
    u_xlat16_6.x = (-u_xlat16_5.x) * u_xlat16_3.z + u_xlat16_4.x;
    u_xlat16_6.z = u_xlat16_4.y * u_xlat16_3.z + u_xlat16_5.z;
    u_xlat16_4.x = u_xlat16_5.x * u_xlat16_2.z + u_xlat16_5.y;
    u_xlat16_3.xzw = vec3(u_xlat16_3.y * u_xlat16_3.x, u_xlat16_3.z * u_xlat16_3.y, u_xlat16_3.z * u_xlat16_3.x);
    u_xlat16_6.y = u_xlat16_3.z;
    u_xlat16_19 = dot(u_xlat16_6.xyz, u_xlat1.xyz);
    u_xlat16_5.z = (-u_xlat16_2.x) * u_xlat16_3.y;
    u_xlat16_5.y = u_xlat16_2.y;
    u_xlat16_5.x = u_xlat16_3.x;
    u_xlat16_10 = dot(u_xlat16_5.xyz, u_xlat1.xyz);
    u_xlat16_3.x = max(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_28 = min(abs(u_xlat16_10), abs(u_xlat16_19));
    u_xlat16_3.x = u_xlat16_3.x * u_xlat16_28;
    u_xlat16_28 = u_xlat16_3.x * u_xlat16_3.x;
    u_xlat25 = u_xlat16_28 * 0.0208350997 + -0.0851330012;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.180141002;
    u_xlat25 = u_xlat16_28 * u_xlat25 + -0.330299497;
    u_xlat25 = u_xlat16_28 * u_xlat25 + 0.999866009;
    u_xlat7 = u_xlat25 * u_xlat16_3.x;
    u_xlat7 = u_xlat7 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(abs(u_xlat16_10)<abs(u_xlat16_19));
#else
    u_xlatb15 = abs(u_xlat16_10)<abs(u_xlat16_19);
#endif
    u_xlat7 = u_xlatb15 ? u_xlat7 : float(0.0);
    u_xlat25 = u_xlat16_3.x * u_xlat25 + u_xlat7;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10<(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10<(-u_xlat16_10);
#endif
    u_xlat7 = u_xlatb7 ? -3.14159274 : float(0.0);
    u_xlat25 = u_xlat25 + u_xlat7;
    u_xlat16_3.x = min(u_xlat16_10, u_xlat16_19);
    u_xlat16_10 = max(u_xlat16_10, u_xlat16_19);
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_10>=(-u_xlat16_10));
#else
    u_xlatb7 = u_xlat16_10>=(-u_xlat16_10);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb15 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb15 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlatb7 = u_xlatb7 && u_xlatb15;
    u_xlat25 = (u_xlatb7) ? (-u_xlat25) : u_xlat25;
    u_xlat16_10 = u_xlat25 * 0.159150004;
    u_xlat16_3.x = -abs(u_xlat16_10) + 0.5;
    vs_TEXCOORD6.x = u_xlat16_10 * _RingUScale + _RingEulerAngles3.w;
    u_xlat16_10 = u_xlat16_26 * u_xlat16_3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_10 = min(max(u_xlat16_10, 0.0), 1.0);
#else
    u_xlat16_10 = clamp(u_xlat16_10, 0.0, 1.0);
#endif
    u_xlat16_26 = u_xlat16_10 * -2.0 + 3.0;
    u_xlat16_10 = u_xlat16_10 * u_xlat16_10;
    vs_TEXCOORD6.z = u_xlat16_10 * u_xlat16_26;
    u_xlat16_2.x = (-u_xlat16_2.x) * u_xlat16_5.y;
    u_xlat16_4.z = u_xlat16_2.x * u_xlat16_2.z + u_xlat16_3.w;
    u_xlat16_4.y = u_xlat16_2.z * (-u_xlat16_3.y);
    u_xlat16_2.x = dot(u_xlat16_4.xyz, u_xlat1.xyz);
    u_xlat1.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat9 = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb17 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat9 = sqrt(u_xlat9);
    u_xlat25 = u_xlat9 * u_xlat1.x;
    u_xlat25 = u_xlat25 * -2.0 + 3.14159274;
    u_xlat17 = u_xlatb17 ? u_xlat25 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat9 + u_xlat17;
    u_xlat16_2.x = u_xlat1.x * 0.318309993 + -0.5;
    vs_TEXCOORD6.y = u_xlat16_2.x * _RingVScale + 0.5;
#ifdef UNITY_ADRENO_ES3
    vs_TEXCOORD6.y = min(max(vs_TEXCOORD6.y, 0.0), 1.0);
#else
    vs_TEXCOORD6.y = clamp(vs_TEXCOORD6.y, 0.0, 1.0);
#endif
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _RingColor;
uniform 	mediump float _RingCrossLightIntensity;
uniform 	mediump float _RingCrossLightShininess;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
uniform lowp sampler2D _RingTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in mediump vec3 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec2 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec2 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_5;
lowp vec2 u_xlat10_8;
mediump float u_xlat16_9;
float u_xlat12;
mediump float u_xlat16_13;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_5.x = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_5.x = u_xlat16_1 * _CellRimIntensity + u_xlat16_5.x;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_5.x = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_5.x;
    u_xlat16_9 = log2(vs_TEXCOORD0.x);
    u_xlat16_9 = u_xlat16_9 * _CellRimShininess;
    u_xlat16_9 = exp2(u_xlat16_9);
    u_xlat16_9 = u_xlat16_9 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_5.x + u_xlat16_1;
    u_xlat10_0.xy = texture(_RingTex, vs_TEXCOORD5.xy).xy;
    u_xlat10_8.xy = texture(_RingTex, vs_TEXCOORD6.xy).xy;
    u_xlat16_5.x = u_xlat10_8.y * u_xlat10_0.y;
    u_xlat10_2.xy = texture(_RingTex, vs_TEXCOORD4.xy).xy;
    u_xlat16_9 = u_xlat10_2.y * u_xlat10_0.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_0.y * u_xlat10_2.y;
    u_xlat16_3.x = u_xlat10_0.x * vs_TEXCOORD5.z;
    u_xlat16_3.x = u_xlat10_2.x * vs_TEXCOORD4.z + u_xlat16_3.x;
    u_xlat16_3.x = u_xlat10_8.x * vs_TEXCOORD6.z + u_xlat16_3.x;
    u_xlat16_5.x = (-u_xlat16_13) * u_xlat16_5.x + u_xlat16_9;
    u_xlat16_9 = u_xlat10_8.y * u_xlat10_2.y + u_xlat16_5.x;
    u_xlat16_13 = u_xlat10_8.y * u_xlat10_2.y;
    u_xlat16_5.x = (-u_xlat16_5.x) * u_xlat16_13 + u_xlat16_9;
    u_xlat16_5.x = log2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightShininess;
    u_xlat16_5.x = exp2(u_xlat16_5.x);
    u_xlat16_5.x = u_xlat16_5.x * _RingCrossLightIntensity + u_xlat16_3.x;
    u_xlat16_3.xyz = _RingColor.www * _RingColor.xyz;
    u_xlat16_5.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz + u_xlat16_5.xyz;
    SV_Target0.w = 0.0;
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
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 185914
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat4.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb8 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat12 = u_xlat4.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat8;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_6 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_6 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_10.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_10.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat4.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_6 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_6 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_6 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_6 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_10.xy;
    u_xlat16_0 = u_xlat16_10.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = (-u_xlat1.xyz);
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_10.yyyy + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_3 = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_3 = u_xlat16_1 * _CellRimIntensity + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_3 = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_3;
    u_xlat16_5 = log2(vs_TEXCOORD0.x);
    u_xlat16_5 = u_xlat16_5 * _CellRimShininess;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat4.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb8 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat12 = u_xlat4.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat8;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_6 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_6 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_10.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_10.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat4.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_6 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_6 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_6 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_6 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_10.xy;
    u_xlat16_0 = u_xlat16_10.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = (-u_xlat1.xyz);
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_10.yyyy + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_3 = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_3 = u_xlat16_1 * _CellRimIntensity + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_3 = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_3;
    u_xlat16_5 = log2(vs_TEXCOORD0.x);
    u_xlat16_5 = u_xlat16_5 * _CellRimShininess;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat4.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb8 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat12 = u_xlat4.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat8;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_6 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_6 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_10.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_10.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat4.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_6 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_6 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_6 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_6 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_10.xy;
    u_xlat16_0 = u_xlat16_10.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = (-u_xlat1.xyz);
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_10.yyyy + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_3 = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_3 = u_xlat16_1 * _CellRimIntensity + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_3 = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_3;
    u_xlat16_5 = log2(vs_TEXCOORD0.x);
    u_xlat16_5 = u_xlat16_5 * _CellRimShininess;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
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
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 201121
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat4.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb8 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat12 = u_xlat4.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat8;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_6 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_6 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_10.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_10.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat4.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_6 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_6 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_6 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_6 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_10.xy;
    u_xlat16_0 = u_xlat16_10.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_10.yyyy + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_3 = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_3 = u_xlat16_1 * _CellRimIntensity + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_3 = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_3;
    u_xlat16_5 = log2(vs_TEXCOORD0.x);
    u_xlat16_5 = u_xlat16_5 * _CellRimShininess;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat4.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb8 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat12 = u_xlat4.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat8;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_6 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_6 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_10.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_10.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat4.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_6 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_6 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_6 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_6 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_10.xy;
    u_xlat16_0 = u_xlat16_10.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_10.yyyy + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_3 = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_3 = u_xlat16_1 * _CellRimIntensity + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_3 = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_3;
    u_xlat16_5 = log2(vs_TEXCOORD0.x);
    u_xlat16_5 = u_xlat16_5 * _CellRimShininess;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
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
uniform 	mediump vec4 _Color;
uniform 	mediump float _CellShrink;
uniform 	mediump vec4 _HitPosition;
uniform 	mediump float _HitDistRange;
uniform 	mediump float _HitDistSmoothRange;
uniform 	mediump float _HitAnmStartTime;
uniform 	mediump float _HitAnmEndTime;
uniform 	mediump vec4 _BandPosition;
uniform 	mediump float _BandWidth;
uniform 	mediump float _BandIntensity;
uniform 	mediump vec4 _Params2;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD1;
out highp vec3 vs_TEXCOORD2;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
mediump float u_xlat16_6;
float u_xlat8;
bool u_xlatb8;
mediump vec2 u_xlat16_10;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0.xyz = _BandPosition.zxy * vec3(0.0, 1.0, 0.0);
    u_xlat0.xyz = _BandPosition.xyz * vec3(0.0, 0.0, 1.0) + (-u_xlat0.xyz);
    u_xlat1.xyz = u_xlat0.xyz * _BandPosition.zxy;
    u_xlat0.xyz = _BandPosition.yzx * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat16_2.xxx;
    u_xlat0.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat0.xyz = u_xlat0.xxx * in_NORMAL0.xyz;
    u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat16_2.xyz);
    u_xlat0.x = abs(u_xlat16_2.x) * -0.0187292993 + 0.0742610022;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + -0.212114394;
    u_xlat0.x = u_xlat0.x * abs(u_xlat16_2.x) + 1.57072878;
    u_xlat4.x = -abs(u_xlat16_2.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat16_2.x<(-u_xlat16_2.x));
#else
    u_xlatb8 = u_xlat16_2.x<(-u_xlat16_2.x);
#endif
    u_xlat4.x = sqrt(u_xlat4.x);
    u_xlat12 = u_xlat4.x * u_xlat0.x;
    u_xlat12 = u_xlat12 * -2.0 + 3.14159274;
    u_xlat8 = u_xlatb8 ? u_xlat12 : float(0.0);
    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat8;
    u_xlat16_2.x = u_xlat0.x + (-_BandPosition.w);
    u_xlat16_2.x = cos(u_xlat16_2.x);
    u_xlat16_6 = float(1.0) / _BandWidth;
    u_xlat16_2.x = u_xlat16_6 * abs(u_xlat16_2.x);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_10.y = u_xlat16_2.x * _BandIntensity;
    u_xlat16_2.x = u_xlat16_10.y * 0.00400000019;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat0.x = _CellShrink * 0.00999999978 + u_xlat16_2.x;
    u_xlat4.xyz = (-in_POSITION0.xyz) + in_NORMAL0.xyz;
    u_xlat0.xyz = u_xlat4.xyz * u_xlat0.xxx + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD2.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat16_2.x = dot(_HitPosition, _HitPosition);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat0.xyz = (-_HitPosition.xyz) * u_xlat16_2.xxx + in_NORMAL0.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat16_2.x = (-_HitDistRange) * _HitAnmStartTime + u_xlat0.x;
    u_xlat16_6 = float(1.0) / _HitDistSmoothRange;
    u_xlat16_2.x = u_xlat16_6 * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = (-u_xlat16_6) * u_xlat16_2.x + 1.0;
    u_xlat16_2.x = u_xlat16_2.x * _Params2.z;
    u_xlat16_6 = (-_HitAnmEndTime) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6 = min(max(u_xlat16_6, 0.0), 1.0);
#else
    u_xlat16_6 = clamp(u_xlat16_6, 0.0, 1.0);
#endif
    u_xlat16_10.x = u_xlat16_6 * u_xlat16_2.x;
    vs_TEXCOORD3.xy = u_xlat16_10.xy;
    u_xlat16_0 = u_xlat16_10.xxxx * _Color;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    vs_TEXCOORD1.xyz = u_xlat1.xyz;
    u_xlat1.xyz = in_NORMAL0.xyz * vec3(12.9898005, 78.2330017, 45.5432014);
    u_xlat1.xyz = sin(u_xlat1.xyz);
    u_xlat1.xyz = u_xlat1.xyz * vec3(43758.5469, 43758.5469, 43758.5469);
    u_xlat1.xyz = fract(u_xlat1.xyz);
    u_xlat1.x = dot(u_xlat1.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat1.x = max(u_xlat1.x, 0.5);
    u_xlat16_3 = in_COLOR0 * _Color;
    u_xlat16_0 = u_xlat16_3 * u_xlat1.xxxx + u_xlat16_0;
    vs_COLOR0 = _Color * u_xlat16_10.yyyy + u_xlat16_0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec4 _FresnelParams;
uniform 	mediump float _CellRimShininess;
uniform 	mediump float _CellRimIntensity;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD2;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
mediump float u_xlat16_5;
float u_xlat6;
void main()
{
    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
    u_xlat16_1 = dot(u_xlat0.xyz, vs_TEXCOORD1.xyz);
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_1 = max(u_xlat16_1, 0.00100000005);
    u_xlat16_1 = min(u_xlat16_1, 1.0);
    u_xlat16_1 = log2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.x;
    u_xlat16_1 = exp2(u_xlat16_1);
    u_xlat16_1 = u_xlat16_1 * _FresnelParams.y;
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlat16_1 = u_xlat16_1 + _FresnelParams.z;
    u_xlat16_3 = vs_TEXCOORD3.x * 0.00999999978;
    u_xlat16_3 = u_xlat16_1 * _CellRimIntensity + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + vs_COLOR0.w;
    u_xlat16_3 = vs_TEXCOORD3.y * 0.0500000007 + u_xlat16_3;
    u_xlat16_5 = log2(vs_TEXCOORD0.x);
    u_xlat16_5 = u_xlat16_5 * _CellRimShininess;
    u_xlat16_5 = exp2(u_xlat16_5);
    u_xlat16_5 = u_xlat16_5 * vs_COLOR0.x;
    u_xlat16_1 = u_xlat16_5 * u_xlat16_3 + u_xlat16_1;
    SV_Target0.xyz = vec3(u_xlat16_1) * vs_COLOR0.xyz;
    SV_Target0.w = 0.0;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}