//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Ripple" {
Properties {
_MainTex ("Main", 2D) = "white" { }
_RainIntensity ("Rain Intensity", Range(0, 1)) = 1
_RainTime ("Rain Time", Vector) = (0,0,0,0)
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 11055
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _RainIntensity;
uniform 	vec4 _RainTime;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
float u_xlat8;
float u_xlat9;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0 = vs_TEXCOORD0.xyxy + vec4(0.25, 0.0, -0.550000012, 0.300000012);
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat13 = u_xlat10_1.w + _RainTime.y;
    u_xlat13 = fract(u_xlat13);
    u_xlat2 = u_xlat10_1.x + u_xlat13;
    u_xlat2 = u_xlat2 + -1.0;
    u_xlat2 = u_xlat2 * 9.0;
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat2 = min(u_xlat2, 3.0);
    u_xlat2 = u_xlat2 * 3.14159274;
    u_xlat2 = sin(u_xlat2);
    u_xlat6.xy = vec2(_RainIntensity) + vec2(-0.0, -0.25);
    u_xlat3.xy = u_xlat6.xy * vec2(0.800000012, 0.800000012) + vec2(0.200000003, 0.200000003);
    u_xlat13 = (-u_xlat13) + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10_1.x * u_xlat13;
    u_xlat16_5.xy = u_xlat10_1.yz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat2 * u_xlat1.x;
    u_xlat1.xy = u_xlat1.xx * u_xlat16_5.xy;
    u_xlat1.xy = u_xlat6.yy * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.349999994, 0.349999994);
    u_xlat12 = u_xlat10_0.w + _RainTime.x;
    u_xlat12 = fract(u_xlat12);
    u_xlat9 = u_xlat10_0.x + u_xlat12;
    u_xlat12 = (-u_xlat12) + u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.x * u_xlat12;
    u_xlat16_4.xy = u_xlat10_0.yz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat12 = u_xlat9 + -1.0;
    u_xlat12 = u_xlat12 * 9.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlat12 = u_xlat12 * 3.14159274;
    u_xlat12 = sin(u_xlat12);
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.xy = u_xlat0.xx * u_xlat16_4.xy;
    u_xlat0.xy = u_xlat6.xx * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.349999994, 0.349999994) + u_xlat1.xy;
    u_xlat0.z = 1.0;
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.z = inversesqrt(u_xlat8);
    u_xlat1.xy = u_xlat0.xy * u_xlat1.zz;
    SV_TARGET0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_TARGET0.w = 1.0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _RainIntensity;
uniform 	vec4 _RainTime;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
float u_xlat8;
float u_xlat9;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0 = vs_TEXCOORD0.xyxy + vec4(0.25, 0.0, -0.550000012, 0.300000012);
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat13 = u_xlat10_1.w + _RainTime.y;
    u_xlat13 = fract(u_xlat13);
    u_xlat2 = u_xlat10_1.x + u_xlat13;
    u_xlat2 = u_xlat2 + -1.0;
    u_xlat2 = u_xlat2 * 9.0;
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat2 = min(u_xlat2, 3.0);
    u_xlat2 = u_xlat2 * 3.14159274;
    u_xlat2 = sin(u_xlat2);
    u_xlat6.xy = vec2(_RainIntensity) + vec2(-0.0, -0.25);
    u_xlat3.xy = u_xlat6.xy * vec2(0.800000012, 0.800000012) + vec2(0.200000003, 0.200000003);
    u_xlat13 = (-u_xlat13) + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10_1.x * u_xlat13;
    u_xlat16_5.xy = u_xlat10_1.yz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat2 * u_xlat1.x;
    u_xlat1.xy = u_xlat1.xx * u_xlat16_5.xy;
    u_xlat1.xy = u_xlat6.yy * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.349999994, 0.349999994);
    u_xlat12 = u_xlat10_0.w + _RainTime.x;
    u_xlat12 = fract(u_xlat12);
    u_xlat9 = u_xlat10_0.x + u_xlat12;
    u_xlat12 = (-u_xlat12) + u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.x * u_xlat12;
    u_xlat16_4.xy = u_xlat10_0.yz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat12 = u_xlat9 + -1.0;
    u_xlat12 = u_xlat12 * 9.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlat12 = u_xlat12 * 3.14159274;
    u_xlat12 = sin(u_xlat12);
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.xy = u_xlat0.xx * u_xlat16_4.xy;
    u_xlat0.xy = u_xlat6.xx * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.349999994, 0.349999994) + u_xlat1.xy;
    u_xlat0.z = 1.0;
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.z = inversesqrt(u_xlat8);
    u_xlat1.xy = u_xlat0.xy * u_xlat1.zz;
    SV_TARGET0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_TARGET0.w = 1.0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _RainIntensity;
uniform 	vec4 _RainTime;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_TARGET0;
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
float u_xlat2;
vec2 u_xlat3;
mediump vec2 u_xlat16_4;
mediump vec2 u_xlat16_5;
vec2 u_xlat6;
float u_xlat8;
float u_xlat9;
float u_xlat12;
float u_xlat13;
void main()
{
    u_xlat0 = vs_TEXCOORD0.xyxy + vec4(0.25, 0.0, -0.550000012, 0.300000012);
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat13 = u_xlat10_1.w + _RainTime.y;
    u_xlat13 = fract(u_xlat13);
    u_xlat2 = u_xlat10_1.x + u_xlat13;
    u_xlat2 = u_xlat2 + -1.0;
    u_xlat2 = u_xlat2 * 9.0;
    u_xlat2 = max(u_xlat2, 0.0);
    u_xlat2 = min(u_xlat2, 3.0);
    u_xlat2 = u_xlat2 * 3.14159274;
    u_xlat2 = sin(u_xlat2);
    u_xlat6.xy = vec2(_RainIntensity) + vec2(-0.0, -0.25);
    u_xlat3.xy = u_xlat6.xy * vec2(0.800000012, 0.800000012) + vec2(0.200000003, 0.200000003);
    u_xlat13 = (-u_xlat13) + u_xlat3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat13 = min(max(u_xlat13, 0.0), 1.0);
#else
    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
#endif
    u_xlat1.x = u_xlat10_1.x * u_xlat13;
    u_xlat16_5.xy = u_xlat10_1.yz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat1.x = u_xlat2 * u_xlat1.x;
    u_xlat1.xy = u_xlat1.xx * u_xlat16_5.xy;
    u_xlat1.xy = u_xlat6.yy * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(0.349999994, 0.349999994);
    u_xlat12 = u_xlat10_0.w + _RainTime.x;
    u_xlat12 = fract(u_xlat12);
    u_xlat9 = u_xlat10_0.x + u_xlat12;
    u_xlat12 = (-u_xlat12) + u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
#else
    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat10_0.x * u_xlat12;
    u_xlat16_4.xy = u_xlat10_0.yz * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat12 = u_xlat9 + -1.0;
    u_xlat12 = u_xlat12 * 9.0;
    u_xlat12 = max(u_xlat12, 0.0);
    u_xlat12 = min(u_xlat12, 3.0);
    u_xlat12 = u_xlat12 * 3.14159274;
    u_xlat12 = sin(u_xlat12);
    u_xlat0.x = u_xlat12 * u_xlat0.x;
    u_xlat0.xy = u_xlat0.xx * u_xlat16_4.xy;
    u_xlat0.xy = u_xlat6.xx * u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(0.349999994, 0.349999994) + u_xlat1.xy;
    u_xlat0.z = 1.0;
    u_xlat8 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat1.z = inversesqrt(u_xlat8);
    u_xlat1.xy = u_xlat0.xy * u_xlat1.zz;
    SV_TARGET0.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
    SV_TARGET0.w = 1.0;
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
}