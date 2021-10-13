//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Grass_Lightmap_CamClip (Wind)" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_LightMapIntensity ("Light Map Intensity", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_WindMagnitude ("Wind Magnitude", Float) = 0
_WindMagnitudeLimit ("Wind Magnitude Limit", Float) = 0.1
_WindFrequency ("Wind Frequency", Float) = 1
_WindWaveVelocity ("Wind Wave Velocity", Float) = 1
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_WindMultiMagnitude ("Wind Multi-Magnitude", Vector) = (1,0.5,0.25,0.125)
_WindMultiFrequency ("Wind Multi-Frequency", Vector) = (1.975,0.793,0.375,0.193)
_WindMultiWaveVelocity ("Wind Multi-Wave Velocity", Vector) = (1,1,1,1)
_RadialWind1 ("Radial Wind 1", Vector) = (0,0,0,1)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 44177
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "LUMINANCE" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
float u_xlat0;
vec4 u_xlat1;
bool u_xlatb1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
float u_xlat5;
vec3 u_xlat6;
vec3 u_xlat8;
float u_xlat10;
float u_xlat11;
float u_xlat13;
float u_xlat15;
float u_xlat17;
float u_xlat18;
bool u_xlatb19;
void main()
{
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat0;
    u_xlat5 = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat5;
    u_xlat5 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat5;
    u_xlat10 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat10;
    u_xlat10 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat10;
    u_xlat15 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat15;
    u_xlat15 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat15;
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(0.5<_FogColorNear.w);
#else
    u_xlatb1 = 0.5<_FogColorNear.w;
#endif
    if(u_xlatb1){
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
        u_xlat1.xy = u_xlat1.xy * (-u_xlat1.xy);
        u_xlat1.xy = u_xlat1.xy * vec2(1.44269502, 1.44269502);
        u_xlat1.xy = exp2(u_xlat1.xy);
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat1.x = u_xlat1.x * _FogEffectLimit;
        u_xlat1.x = max(u_xlat1.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat1.x, _FogEffectLimit);
        u_xlat1.xzw = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.yyy * u_xlat1.xzw + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
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
        u_xlat11 = (-_FogStartDistance) + _FogEndDistance;
        u_xlat11 = max(u_xlat11, 0.100000001);
        u_xlat1.xy = u_xlat1.yx / vec2(u_xlat11);
        u_xlat6.x = u_xlat1.y * _FogEffectLimit;
        u_xlat6.x = max(u_xlat6.x, _FogEffectStart);
        u_xlat2.w = min(u_xlat6.x, _FogEffectLimit);
        u_xlat1.x = u_xlat1.x;
#ifdef UNITY_ADRENO_ES3
        u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
        u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
        u_xlat1.x = (-u_xlat1.x) + 1.0;
        u_xlat6.xyz = _FogColorNear.xyz + (-_FogColorFar.xyz);
        u_xlat2.xyz = u_xlat1.xxx * u_xlat6.xyz + _FogColorFar.xyz;
        vs_COLOR1 = u_xlat2;
    //ENDIF
    }
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 / u_xlat1.wwww;
    u_xlat2.x = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat2.x = inversesqrt(u_xlat2.x);
    u_xlat2.xyz = u_xlat2.xxx * _WindDirection.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat1.xyz);
    u_xlat3.x = _Time.y * _WindFrequency;
    u_xlat17 = u_xlat17 * _WindWaveVelocity;
    u_xlat4 = vec4(u_xlat17) * _WindMultiWaveVelocity;
    u_xlat3 = u_xlat3.xxxx * _WindMultiFrequency + u_xlat4;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat17 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat3.xy = u_xlat1.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat3.xy, u_xlat3.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat4.xz = u_xlat3.xy / vec2(u_xlat13);
    u_xlat4.y = 0.0;
    u_xlat3.x = u_xlat13 + -5.0;
    u_xlat3.x = u_xlat3.x * 4.0;
    u_xlat8.x = min(abs(u_xlat3.x), 1.0);
    u_xlat13 = max(abs(u_xlat3.x), 1.0);
    u_xlat13 = float(1.0) / u_xlat13;
    u_xlat8.x = u_xlat13 * u_xlat8.x;
    u_xlat13 = u_xlat8.x * u_xlat8.x;
    u_xlat18 = u_xlat13 * 0.0208350997 + -0.0851330012;
    u_xlat18 = u_xlat13 * u_xlat18 + 0.180141002;
    u_xlat18 = u_xlat13 * u_xlat18 + -0.330299497;
    u_xlat13 = u_xlat13 * u_xlat18 + 0.999866009;
    u_xlat18 = u_xlat13 * u_xlat8.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(1.0<abs(u_xlat3.x));
#else
    u_xlatb19 = 1.0<abs(u_xlat3.x);
#endif
    u_xlat18 = u_xlat18 * -2.0 + 1.57079637;
    u_xlat18 = u_xlatb19 ? u_xlat18 : float(0.0);
    u_xlat8.x = u_xlat8.x * u_xlat13 + u_xlat18;
    u_xlat3.x = min(u_xlat3.x, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(u_xlat3.x<(-u_xlat3.x));
#else
    u_xlatb3 = u_xlat3.x<(-u_xlat3.x);
#endif
    u_xlat3.x = (u_xlatb3) ? (-u_xlat8.x) : u_xlat8.x;
    u_xlat3.x = (-u_xlat3.x) + 1.58000004;
    u_xlat8.xyz = u_xlat4.xyz * _RadialWind1.www;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat8.xyz;
    u_xlat3.xyz = u_xlat3.xyz * in_COLOR0.xxx;
    u_xlat2.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat3.xyz;
    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat17 = sqrt(u_xlat17);
    u_xlat3.x = log2(_WindMagnitudeLimit);
    u_xlat3.x = u_xlat3.x * 0.693147182 + (-u_xlat17);
    u_xlat3.x = u_xlat3.x * 1.44269502;
    u_xlat3.x = exp2(u_xlat3.x);
    u_xlat3.x = (-u_xlat3.x) + _WindMagnitudeLimit;
    u_xlat17 = u_xlat3.x / u_xlat17;
    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
    u_xlat17 = in_COLOR0.x * _WindMagnitude;
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat17) + u_xlat1.xyz;
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat5 = u_xlat5 * u_xlat1.y;
    u_xlat0 = u_xlat0 * u_xlat1.x + u_xlat5;
    u_xlat0 = u_xlat10 * u_xlat1.z + u_xlat0;
    u_xlat0 = u_xlat15 * u_xlat1.w + u_xlat0;
    u_xlat0 = (-u_xlat0) + (-_ProjectionParams.y);
    u_xlat0 = u_xlat0 + (-_FadeOffset);
    u_xlat0 = u_xlat0 / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = u_xlat2.xy;
    vs_TEXCOORD3 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat13 = u_xlat1.z * _HeigtFogParams.x;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat16_5 = (-u_xlat7) + 2.0;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat7 = u_xlat7 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat13 = u_xlat1.z * _HeigtFogParams.x;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat16_5 = (-u_xlat7) + 2.0;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat7 = u_xlat7 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat13 = u_xlat1.z * _HeigtFogParams.x;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat16_5 = (-u_xlat7) + 2.0;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat7 = u_xlat7 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "LUMINANCE" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat13 = u_xlat1.z * _HeigtFogParams.x;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat16_5 = (-u_xlat7) + 2.0;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat7 = u_xlat7 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat13 = u_xlat1.z * _HeigtFogParams.x;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat16_5 = (-u_xlat7) + 2.0;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat7 = u_xlat7 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
uniform 	vec4 _MainTex_ST;
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec4 u_xlat3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
float u_xlat7;
float u_xlat8;
bool u_xlatb8;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat7 = u_xlat1.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat13 = u_xlat1.z * _HeigtFogParams.x;
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase.w);
    u_xlat16_5 = (-u_xlat7) + 2.0;
    u_xlat16_5 = u_xlat7 * u_xlat16_5;
    u_xlat2.xyz = vec3(u_xlat16_5) * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat3.xyz = (-u_xlat2.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat7 = u_xlat1.x + (-_HeigtFogRamp.w);
    u_xlat7 = u_xlat7 * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7 = min(max(u_xlat7, 0.0), 1.0);
#else
    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
#endif
    u_xlat2.xyz = vec3(u_xlat7) * u_xlat3.xyz + u_xlat2.xyz;
    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
    u_xlat7 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat19 = u_xlat19 / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7;
    u_xlat3.xyz = _Mihoyo_FogColor.xyz * u_xlat1.xxx + u_xlat2.xyz;
    vs_COLOR1 = u_xlat3;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    SV_Target0.xyz = u_xlat16_0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta3.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor3.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase3.w);
    u_xlat2.x = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat2.x) + 2.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat21 = u_xlat1.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xzw = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat2.xzw = vec3(u_xlat19) * u_xlat2.xzw;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat3.x = u_xlat1.z * _HeigtFogParams3.x;
    u_xlat13 = u_xlat1.z * _HeigtFogParams2.x;
    u_xlat9 = u_xlat3.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_5 = (u_xlatb3) ? u_xlat9 : 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat3.x) + 2.0;
    u_xlat16_11 = u_xlat3.x * u_xlat16_11;
    u_xlat3.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat3.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat2.xzw = u_xlat2.xzw * vec3(u_xlat9);
    u_xlat4.w = u_xlat19 * u_xlat9;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat2.xzw;
    u_xlat16_5 = (-u_xlat7.x) + 2.0;
    u_xlat16_5 = u_xlat7.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xzw = u_xlat7.xxx * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat7.x = u_xlat1.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat19 * u_xlat7.x;
    u_xlat19 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb8) ? u_xlat19 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xzw;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat7.z = exp2(u_xlat19);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat19 = u_xlat7.z / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta3.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor3.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase3.w);
    u_xlat2.x = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat2.x) + 2.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat21 = u_xlat1.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xzw = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat2.xzw = vec3(u_xlat19) * u_xlat2.xzw;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat3.x = u_xlat1.z * _HeigtFogParams3.x;
    u_xlat13 = u_xlat1.z * _HeigtFogParams2.x;
    u_xlat9 = u_xlat3.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_5 = (u_xlatb3) ? u_xlat9 : 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat3.x) + 2.0;
    u_xlat16_11 = u_xlat3.x * u_xlat16_11;
    u_xlat3.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat3.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat2.xzw = u_xlat2.xzw * vec3(u_xlat9);
    u_xlat4.w = u_xlat19 * u_xlat9;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat2.xzw;
    u_xlat16_5 = (-u_xlat7.x) + 2.0;
    u_xlat16_5 = u_xlat7.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xzw = u_xlat7.xxx * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat7.x = u_xlat1.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat19 * u_xlat7.x;
    u_xlat19 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb8) ? u_xlat19 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xzw;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat7.z = exp2(u_xlat19);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat19 = u_xlat7.z / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta3.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor3.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase3.w);
    u_xlat2.x = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat2.x) + 2.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat21 = u_xlat1.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xzw = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat2.xzw = vec3(u_xlat19) * u_xlat2.xzw;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat3.x = u_xlat1.z * _HeigtFogParams3.x;
    u_xlat13 = u_xlat1.z * _HeigtFogParams2.x;
    u_xlat9 = u_xlat3.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_5 = (u_xlatb3) ? u_xlat9 : 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat3.x) + 2.0;
    u_xlat16_11 = u_xlat3.x * u_xlat16_11;
    u_xlat3.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat3.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat2.xzw = u_xlat2.xzw * vec3(u_xlat9);
    u_xlat4.w = u_xlat19 * u_xlat9;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat2.xzw;
    u_xlat16_5 = (-u_xlat7.x) + 2.0;
    u_xlat16_5 = u_xlat7.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xzw = u_xlat7.xxx * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat7.x = u_xlat1.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat19 * u_xlat7.x;
    u_xlat19 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb8) ? u_xlat19 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xzw;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat7.z = exp2(u_xlat19);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat19 = u_xlat7.z / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    SV_Target0.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    SV_Target0.w = vs_TEXCOORD3;
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta3.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor3.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase3.w);
    u_xlat2.x = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat2.x) + 2.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat21 = u_xlat1.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xzw = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat2.xzw = vec3(u_xlat19) * u_xlat2.xzw;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat3.x = u_xlat1.z * _HeigtFogParams3.x;
    u_xlat13 = u_xlat1.z * _HeigtFogParams2.x;
    u_xlat9 = u_xlat3.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_5 = (u_xlatb3) ? u_xlat9 : 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat3.x) + 2.0;
    u_xlat16_11 = u_xlat3.x * u_xlat16_11;
    u_xlat3.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat3.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat2.xzw = u_xlat2.xzw * vec3(u_xlat9);
    u_xlat4.w = u_xlat19 * u_xlat9;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat2.xzw;
    u_xlat16_5 = (-u_xlat7.x) + 2.0;
    u_xlat16_5 = u_xlat7.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xzw = u_xlat7.xxx * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat7.x = u_xlat1.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat19 * u_xlat7.x;
    u_xlat19 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb8) ? u_xlat19 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xzw;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat7.z = exp2(u_xlat19);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat19 = u_xlat7.z / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta3.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor3.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase3.w);
    u_xlat2.x = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat2.x) + 2.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat21 = u_xlat1.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xzw = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat2.xzw = vec3(u_xlat19) * u_xlat2.xzw;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat3.x = u_xlat1.z * _HeigtFogParams3.x;
    u_xlat13 = u_xlat1.z * _HeigtFogParams2.x;
    u_xlat9 = u_xlat3.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_5 = (u_xlatb3) ? u_xlat9 : 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat3.x) + 2.0;
    u_xlat16_11 = u_xlat3.x * u_xlat16_11;
    u_xlat3.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat3.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat2.xzw = u_xlat2.xzw * vec3(u_xlat9);
    u_xlat4.w = u_xlat19 * u_xlat9;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat2.xzw;
    u_xlat16_5 = (-u_xlat7.x) + 2.0;
    u_xlat16_5 = u_xlat7.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xzw = u_xlat7.xxx * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat7.x = u_xlat1.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat19 * u_xlat7.x;
    u_xlat19 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb8) ? u_xlat19 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xzw;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat7.z = exp2(u_xlat19);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat19 = u_xlat7.z / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
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
uniform 	mediump vec4 _ShadowTex_ST;
uniform 	float _WindMagnitude;
uniform 	float _WindFrequency;
uniform 	float _WindWaveVelocity;
uniform 	float _WindMagnitudeLimit;
uniform 	vec3 _WindDirection;
uniform 	vec4 _WindMultiMagnitude;
uniform 	vec4 _WindMultiFrequency;
uniform 	vec4 _WindMultiWaveVelocity;
uniform 	vec4 _RadialWind1;
uniform 	float _FadeDistance;
uniform 	float _FadeOffset;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec4 in_COLOR0;
in mediump vec2 in_TEXCOORD1;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
out mediump float vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
bool u_xlatb3;
vec4 u_xlat4;
mediump float u_xlat16_5;
float u_xlat6;
vec3 u_xlat7;
float u_xlat8;
bool u_xlatb8;
float u_xlat9;
mediump float u_xlat16_11;
float u_xlat13;
bool u_xlatb13;
float u_xlat14;
float u_xlat19;
bool u_xlatb19;
bool u_xlatb20;
float u_xlat21;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = u_xlat0 / u_xlat0.wwww;
    u_xlat1.xy = u_xlat0.xz + (-_RadialWind1.xz);
    u_xlat13 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat13 = sqrt(u_xlat13);
    u_xlat13 = max(u_xlat13, 0.00999999978);
    u_xlat19 = u_xlat13 + -5.0;
    u_xlat1.xz = u_xlat1.xy / vec2(u_xlat13);
    u_xlat19 = u_xlat19 * 4.0;
    u_xlat2.x = max(abs(u_xlat19), 1.0);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat8 = min(abs(u_xlat19), 1.0);
    u_xlat2.x = u_xlat2.x * u_xlat8;
    u_xlat8 = u_xlat2.x * u_xlat2.x;
    u_xlat14 = u_xlat8 * 0.0208350997 + -0.0851330012;
    u_xlat14 = u_xlat8 * u_xlat14 + 0.180141002;
    u_xlat14 = u_xlat8 * u_xlat14 + -0.330299497;
    u_xlat8 = u_xlat8 * u_xlat14 + 0.999866009;
    u_xlat14 = u_xlat8 * u_xlat2.x;
    u_xlat14 = u_xlat14 * -2.0 + 1.57079637;
#ifdef UNITY_ADRENO_ES3
    u_xlatb20 = !!(1.0<abs(u_xlat19));
#else
    u_xlatb20 = 1.0<abs(u_xlat19);
#endif
    u_xlat19 = min(u_xlat19, 1.0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(u_xlat19<(-u_xlat19));
#else
    u_xlatb19 = u_xlat19<(-u_xlat19);
#endif
    u_xlat14 = u_xlatb20 ? u_xlat14 : float(0.0);
    u_xlat2.x = u_xlat2.x * u_xlat8 + u_xlat14;
    u_xlat19 = (u_xlatb19) ? (-u_xlat2.x) : u_xlat2.x;
    u_xlat19 = (-u_xlat19) + 1.58000004;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz * _RadialWind1.www;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_COLOR0.xxx;
    u_xlat19 = dot(_WindDirection.xyz, _WindDirection.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat2.xyz = vec3(u_xlat19) * _WindDirection.xyz;
    u_xlat19 = dot(u_xlat2.xyz, u_xlat0.xyz);
    u_xlat19 = u_xlat19 * _WindWaveVelocity;
    u_xlat3 = vec4(u_xlat19) * _WindMultiWaveVelocity;
    u_xlat19 = _Time.y * _WindFrequency;
    u_xlat3 = vec4(u_xlat19) * _WindMultiFrequency + u_xlat3;
    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
    u_xlat3 = fract(u_xlat3);
    u_xlat3 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat4 = abs(u_xlat3) * abs(u_xlat3);
    u_xlat3 = -abs(u_xlat3) * vec4(2.0, 2.0, 2.0, 2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat3 = u_xlat4 * u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat19 = dot(u_xlat3, _WindMultiMagnitude);
    u_xlat1.xyz = u_xlat2.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = sqrt(u_xlat19);
    u_xlat2.x = log2(_WindMagnitudeLimit);
    u_xlat2.x = u_xlat2.x * 0.693147182 + (-u_xlat19);
    u_xlat2.x = u_xlat2.x * 1.44269502;
    u_xlat2.x = exp2(u_xlat2.x);
    u_xlat2.x = (-u_xlat2.x) + _WindMagnitudeLimit;
    u_xlat19 = u_xlat2.x / u_xlat19;
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat19 = in_COLOR0.x * _WindMagnitude;
    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat19) + u_xlat0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat1.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _ShadowTex_ST.xy + _ShadowTex_ST.zw;
    u_xlat1.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xzw = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat1.x = dot(u_xlat1.xzw, u_xlat1.xzw);
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat19 = u_xlat1.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat2.x = (-u_xlat19) + 2.0;
    u_xlat19 = u_xlat19 * u_xlat2.x;
    u_xlat2.x = u_xlat19 * _HeigtFogColDelta3.w;
    u_xlat8 = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat1.x>=u_xlat8);
#else
    u_xlatb8 = u_xlat1.x>=u_xlat8;
#endif
    u_xlat19 = (u_xlatb8) ? u_xlat2.x : u_xlat19;
    u_xlat19 = log2(u_xlat19);
    u_xlat19 = u_xlat19 * _Mihoyo_FogColor3.w;
    u_xlat19 = exp2(u_xlat19);
    u_xlat19 = min(u_xlat19, _HeigtFogColBase3.w);
    u_xlat2.x = u_xlat1.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat2.x = min(max(u_xlat2.x, 0.0), 1.0);
#else
    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
#endif
    u_xlat7.x = u_xlat1.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat16_5 = (-u_xlat2.x) + 2.0;
    u_xlat16_5 = u_xlat2.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol3.xyz;
    u_xlat21 = u_xlat1.x + (-_HeigtFogRamp3.w);
    u_xlat21 = u_xlat21 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat21 = min(max(u_xlat21, 0.0), 1.0);
#else
    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
#endif
    u_xlat2.xzw = vec3(u_xlat21) * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat2.xzw = vec3(u_xlat19) * u_xlat2.xzw;
    u_xlat19 = (-u_xlat19) + 1.0;
    u_xlat3.x = u_xlat1.z * _HeigtFogParams3.x;
    u_xlat13 = u_xlat1.z * _HeigtFogParams2.x;
    u_xlat9 = u_xlat3.x * -1.44269502;
    u_xlat9 = exp2(u_xlat9);
    u_xlat9 = (-u_xlat9) + 1.0;
    u_xlat9 = u_xlat9 / u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb3 = !!(0.00999999978<abs(u_xlat3.x));
#else
    u_xlatb3 = 0.00999999978<abs(u_xlat3.x);
#endif
    u_xlat16_5 = (u_xlatb3) ? u_xlat9 : 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogParams3.y;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat3.x = u_xlat1.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat16_11 = (-u_xlat3.x) + 2.0;
    u_xlat16_11 = u_xlat3.x * u_xlat16_11;
    u_xlat3.x = u_xlat16_11 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat3.x = u_xlat3.x + 1.0;
    u_xlat16_5 = u_xlat3.x * u_xlat16_5;
    u_xlat3.x = min(u_xlat16_5, _HeigtFogColBase3.w);
    u_xlat9 = (-u_xlat3.x) + 1.0;
    u_xlat2.xzw = u_xlat2.xzw * vec3(u_xlat9);
    u_xlat4.w = u_xlat19 * u_xlat9;
    u_xlat4.xyz = _Mihoyo_FogColor3.xyz * u_xlat3.xxx + u_xlat2.xzw;
    u_xlat16_5 = (-u_xlat7.x) + 2.0;
    u_xlat16_5 = u_xlat7.x * u_xlat16_5;
    u_xlat2.xzw = vec3(u_xlat16_5) * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat3.xyz = (-u_xlat2.xzw) + _HeigtFogRadialCol2.xyz;
    u_xlat7.x = u_xlat1.x + (-_HeigtFogRamp2.w);
    u_xlat7.x = u_xlat7.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat2.xzw = u_xlat7.xxx * u_xlat3.xyz + u_xlat2.xzw;
    u_xlat7.x = u_xlat1.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat7.x = min(max(u_xlat7.x, 0.0), 1.0);
#else
    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat7.x) + 2.0;
    u_xlat7.x = u_xlat19 * u_xlat7.x;
    u_xlat19 = u_xlat7.x * _HeigtFogColDelta2.w;
    u_xlat7.x = (u_xlatb8) ? u_xlat19 : u_xlat7.x;
    u_xlat7.x = log2(u_xlat7.x);
    u_xlat7.x = u_xlat7.x * _Mihoyo_FogColor2.w;
    u_xlat7.x = exp2(u_xlat7.x);
    u_xlat7.x = min(u_xlat7.x, _HeigtFogColBase2.w);
    u_xlat2.xyz = u_xlat7.xxx * u_xlat2.xzw;
    u_xlat19 = u_xlat13 * -1.44269502;
    u_xlat7.z = exp2(u_xlat19);
    u_xlat7.xz = (-u_xlat7.xz) + vec2(1.0, 1.0);
    u_xlat19 = u_xlat7.z / u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.00999999978<abs(u_xlat13));
#else
    u_xlatb13 = 0.00999999978<abs(u_xlat13);
#endif
    u_xlat16_5 = (u_xlatb13) ? u_xlat19 : 1.0;
    u_xlat13 = u_xlat1.x * _HeigtFogParams2.y;
    u_xlat1.x = u_xlat1.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat16_5 = u_xlat13 * u_xlat16_5;
    u_xlat16_5 = exp2((-u_xlat16_5));
    u_xlat16_5 = min(u_xlat16_5, 1.0);
    u_xlat16_5 = (-u_xlat16_5) + 1.0;
    u_xlat16_11 = (-u_xlat1.x) + 2.0;
    u_xlat16_11 = u_xlat1.x * u_xlat16_11;
    u_xlat1.x = u_xlat16_11 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat1.x = u_xlat1.x + 1.0;
    u_xlat16_5 = u_xlat1.x * u_xlat16_5;
    u_xlat1.x = min(u_xlat16_5, _HeigtFogColBase2.w);
    u_xlat13 = (-u_xlat1.x) + 1.0;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat3.w = u_xlat13 * u_xlat7.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat1.xxx + u_xlat2.xyz;
    u_xlat1 = (-u_xlat3) + u_xlat4;
    u_xlat1 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat1 + u_xlat3;
    vs_COLOR1 = u_xlat1;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[1].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[1].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[1].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[1].w + u_xlat1.x;
    u_xlat6 = u_xlat0.y * u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_ObjectToWorld[0].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[0].x + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[0].z + u_xlat1.x;
    u_xlat1.x = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[0].w + u_xlat1.x;
    u_xlat0.x = u_xlat1.x * u_xlat0.x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[2].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[2].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[2].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[2].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.z + u_xlat0.x;
    u_xlat6 = hlslcc_mtx4x4unity_ObjectToWorld[3].y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[0].z * hlslcc_mtx4x4unity_ObjectToWorld[3].x + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[2].z * hlslcc_mtx4x4unity_ObjectToWorld[3].z + u_xlat6;
    u_xlat6 = hlslcc_mtx4x4unity_MatrixV[3].z * hlslcc_mtx4x4unity_ObjectToWorld[3].w + u_xlat6;
    u_xlat0.x = u_xlat6 * u_xlat0.w + u_xlat0.x;
    u_xlat0.x = (-u_xlat0.x) + (-_ProjectionParams.y);
    u_xlat0.x = u_xlat0.x + (-_FadeOffset);
    u_xlat0.x = u_xlat0.x / _FadeDistance;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    vs_TEXCOORD3 = u_xlat0.x;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Cutoff;
uniform 	mediump float _LightMapIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
in mediump float vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
int u_xlati12;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1 = u_xlat10_0.w + (-_Cutoff);
    u_xlat16_1 = u_xlat16_1 + 1.0;
    u_xlat16_1 = floor(u_xlat16_1);
    u_xlat16_1 = max(u_xlat16_1, 0.0);
    u_xlati12 = int(u_xlat16_1);
    if((u_xlati12)==0){discard;}
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat16_2.xyz = u_xlat10_0.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity));
    u_xlat16_2.xyz = (-u_xlat16_2.xyz) * vec3(vec3(_LightMapIntensity, _LightMapIntensity, _LightMapIntensity)) + vs_COLOR1.xyz;
    u_xlat16_2.xyz = vs_COLOR1.www * u_xlat16_2.xyz + u_xlat16_3.xyz;
    u_xlat16_0.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-u_xlat16_2.xyz) + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(_LumiFactor) * u_xlat16_0.xyz + u_xlat16_2.xyz;
    SV_Target0.w = vs_TEXCOORD3;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
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
}