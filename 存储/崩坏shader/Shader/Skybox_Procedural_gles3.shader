//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Skybox/Procedural" {
Properties {
[KeywordEnum(None, Simple, High Quality)] _SunDisk ("Sun", Float) = 2
_SunSize ("Sun Size", Range(0, 1)) = 0.04
_SunSizeConvergence ("Sun Size Convergence", Range(1, 10)) = 5
_AtmosphereThickness ("Atmosphere Thickness", Range(0, 5)) = 1
_SkyTint ("Sky Tint", Color) = (0.5,0.5,0.5,1)
_GroundColor ("Ground", Color) = (0.369,0.349,0.341,1)
_Exposure ("Exposure", Range(0, 8)) = 1.3
}
SubShader {
 Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
 Pass {
  Tags { "PreviewType" = "Skybox" "QUEUE" = "Background" "RenderType" = "Background" }
  ZWrite Off
  Cull Off
  GpuProgramID 20516
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "_SUNDISK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out mediump float vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat8;
vec3 u_xlat13;
float u_xlat16;
float u_xlat21;
float u_xlat24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_27;
float u_xlat28;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat24 + u_xlat0.x;
        u_xlat8 = (-u_xlat0.y) * u_xlat24 + 1.0;
        u_xlat16 = u_xlat8 * 5.25 + -6.80000019;
        u_xlat16 = u_xlat8 * u_xlat16 + 3.82999992;
        u_xlat16 = u_xlat8 * u_xlat16 + 0.458999991;
        u_xlat8 = u_xlat8 * u_xlat16 + -0.00286999997;
        u_xlat8 = u_xlat8 * 1.44269502;
        u_xlat0.y = exp2(u_xlat8);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat25 = (-u_xlat24) + 1.0;
        u_xlat25 = u_xlat25 * 230.831207;
        u_xlat25 = exp2(u_xlat25);
        u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat26 = u_xlat26 / u_xlat24;
        u_xlat28 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat24 = u_xlat28 / u_xlat24;
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat28 = u_xlat26 * 5.25 + -6.80000019;
        u_xlat28 = u_xlat26 * u_xlat28 + 3.82999992;
        u_xlat28 = u_xlat26 * u_xlat28 + 0.458999991;
        u_xlat26 = u_xlat26 * u_xlat28 + -0.00286999997;
        u_xlat26 = u_xlat26 * 1.44269502;
        u_xlat26 = exp2(u_xlat26);
        u_xlat24 = (-u_xlat24) + 1.0;
        u_xlat28 = u_xlat24 * 5.25 + -6.80000019;
        u_xlat28 = u_xlat24 * u_xlat28 + 3.82999992;
        u_xlat28 = u_xlat24 * u_xlat28 + 0.458999991;
        u_xlat24 = u_xlat24 * u_xlat28 + -0.00286999997;
        u_xlat24 = u_xlat24 * 1.44269502;
        u_xlat24 = exp2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.25;
        u_xlat24 = u_xlat26 * 0.25 + (-u_xlat24);
        u_xlat24 = u_xlat25 * u_xlat24 + u_xlat0.y;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = min(u_xlat24, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat24 = u_xlat0.z * u_xlat25;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat25 = (-u_xlat0.x) + 1.0;
        u_xlat25 = u_xlat25 * 230.831207;
        u_xlat25 = exp2(u_xlat25);
        u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat26 = u_xlat26 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat4.x = u_xlat26 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat26 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat26 * u_xlat4.x + 0.458999991;
        u_xlat26 = u_xlat26 * u_xlat4.x + -0.00286999997;
        u_xlat26 = u_xlat26 * 1.44269502;
        u_xlat26 = exp2(u_xlat26);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat26 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat25 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat25;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat24) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat26 = min(u_xlat2.y, -0.00100000005);
        u_xlat26 = -9.99999975e-05 / u_xlat26;
        u_xlat5.xyz = vec3(u_xlat26) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat21 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat21 = u_xlat5.y * u_xlat21 + 3.82999992;
        u_xlat21 = u_xlat5.y * u_xlat21 + 0.458999991;
        u_xlat13.x = u_xlat5.y * u_xlat21 + -0.00286999997;
        u_xlat13.x = u_xlat13.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat13.x);
        u_xlat21 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat21 = u_xlat5.x * u_xlat21 + 3.82999992;
        u_xlat21 = u_xlat5.x * u_xlat21 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat21 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat13.xz = vec2(u_xlat26) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat13.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat26 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat26 = u_xlat26 * 230.831207;
        u_xlat26 = exp2(u_xlat26);
        u_xlat5.x = u_xlat26 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat26 = u_xlat13.z * u_xlat26;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat26);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat26 = u_xlat2.y * -50.0;
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_27 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD0 = u_xlat26;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in mediump float vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(vs_TEXCOORD1.x + (-vs_TEXCOORD2.x), vs_TEXCOORD1.y + (-vs_TEXCOORD2.y), vs_TEXCOORD1.z + (-vs_TEXCOORD2.z));
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_SUNDISK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out mediump float vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat8;
vec3 u_xlat13;
float u_xlat16;
float u_xlat21;
float u_xlat24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_27;
float u_xlat28;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat24 + u_xlat0.x;
        u_xlat8 = (-u_xlat0.y) * u_xlat24 + 1.0;
        u_xlat16 = u_xlat8 * 5.25 + -6.80000019;
        u_xlat16 = u_xlat8 * u_xlat16 + 3.82999992;
        u_xlat16 = u_xlat8 * u_xlat16 + 0.458999991;
        u_xlat8 = u_xlat8 * u_xlat16 + -0.00286999997;
        u_xlat8 = u_xlat8 * 1.44269502;
        u_xlat0.y = exp2(u_xlat8);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat25 = (-u_xlat24) + 1.0;
        u_xlat25 = u_xlat25 * 230.831207;
        u_xlat25 = exp2(u_xlat25);
        u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat26 = u_xlat26 / u_xlat24;
        u_xlat28 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat24 = u_xlat28 / u_xlat24;
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat28 = u_xlat26 * 5.25 + -6.80000019;
        u_xlat28 = u_xlat26 * u_xlat28 + 3.82999992;
        u_xlat28 = u_xlat26 * u_xlat28 + 0.458999991;
        u_xlat26 = u_xlat26 * u_xlat28 + -0.00286999997;
        u_xlat26 = u_xlat26 * 1.44269502;
        u_xlat26 = exp2(u_xlat26);
        u_xlat24 = (-u_xlat24) + 1.0;
        u_xlat28 = u_xlat24 * 5.25 + -6.80000019;
        u_xlat28 = u_xlat24 * u_xlat28 + 3.82999992;
        u_xlat28 = u_xlat24 * u_xlat28 + 0.458999991;
        u_xlat24 = u_xlat24 * u_xlat28 + -0.00286999997;
        u_xlat24 = u_xlat24 * 1.44269502;
        u_xlat24 = exp2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.25;
        u_xlat24 = u_xlat26 * 0.25 + (-u_xlat24);
        u_xlat24 = u_xlat25 * u_xlat24 + u_xlat0.y;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = min(u_xlat24, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat24 = u_xlat0.z * u_xlat25;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat25 = (-u_xlat0.x) + 1.0;
        u_xlat25 = u_xlat25 * 230.831207;
        u_xlat25 = exp2(u_xlat25);
        u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat26 = u_xlat26 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat4.x = u_xlat26 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat26 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat26 * u_xlat4.x + 0.458999991;
        u_xlat26 = u_xlat26 * u_xlat4.x + -0.00286999997;
        u_xlat26 = u_xlat26 * 1.44269502;
        u_xlat26 = exp2(u_xlat26);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat26 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat25 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat25;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat24) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat26 = min(u_xlat2.y, -0.00100000005);
        u_xlat26 = -9.99999975e-05 / u_xlat26;
        u_xlat5.xyz = vec3(u_xlat26) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat21 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat21 = u_xlat5.y * u_xlat21 + 3.82999992;
        u_xlat21 = u_xlat5.y * u_xlat21 + 0.458999991;
        u_xlat13.x = u_xlat5.y * u_xlat21 + -0.00286999997;
        u_xlat13.x = u_xlat13.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat13.x);
        u_xlat21 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat21 = u_xlat5.x * u_xlat21 + 3.82999992;
        u_xlat21 = u_xlat5.x * u_xlat21 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat21 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat13.xz = vec2(u_xlat26) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat13.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat26 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat26 = u_xlat26 * 230.831207;
        u_xlat26 = exp2(u_xlat26);
        u_xlat5.x = u_xlat26 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat26 = u_xlat13.z * u_xlat26;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat26);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat26 = u_xlat2.y * -50.0;
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_27 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD0 = u_xlat26;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in mediump float vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(vs_TEXCOORD1.x + (-vs_TEXCOORD2.x), vs_TEXCOORD1.y + (-vs_TEXCOORD2.y), vs_TEXCOORD1.z + (-vs_TEXCOORD2.z));
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_SUNDISK_NONE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out mediump float vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
float u_xlat8;
vec3 u_xlat13;
float u_xlat16;
float u_xlat21;
float u_xlat24;
float u_xlat25;
float u_xlat26;
mediump float u_xlat16_27;
float u_xlat28;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat24 + u_xlat0.x;
        u_xlat8 = (-u_xlat0.y) * u_xlat24 + 1.0;
        u_xlat16 = u_xlat8 * 5.25 + -6.80000019;
        u_xlat16 = u_xlat8 * u_xlat16 + 3.82999992;
        u_xlat16 = u_xlat8 * u_xlat16 + 0.458999991;
        u_xlat8 = u_xlat8 * u_xlat16 + -0.00286999997;
        u_xlat8 = u_xlat8 * 1.44269502;
        u_xlat0.y = exp2(u_xlat8);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat24 = sqrt(u_xlat24);
        u_xlat25 = (-u_xlat24) + 1.0;
        u_xlat25 = u_xlat25 * 230.831207;
        u_xlat25 = exp2(u_xlat25);
        u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat26 = u_xlat26 / u_xlat24;
        u_xlat28 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat24 = u_xlat28 / u_xlat24;
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat28 = u_xlat26 * 5.25 + -6.80000019;
        u_xlat28 = u_xlat26 * u_xlat28 + 3.82999992;
        u_xlat28 = u_xlat26 * u_xlat28 + 0.458999991;
        u_xlat26 = u_xlat26 * u_xlat28 + -0.00286999997;
        u_xlat26 = u_xlat26 * 1.44269502;
        u_xlat26 = exp2(u_xlat26);
        u_xlat24 = (-u_xlat24) + 1.0;
        u_xlat28 = u_xlat24 * 5.25 + -6.80000019;
        u_xlat28 = u_xlat24 * u_xlat28 + 3.82999992;
        u_xlat28 = u_xlat24 * u_xlat28 + 0.458999991;
        u_xlat24 = u_xlat24 * u_xlat28 + -0.00286999997;
        u_xlat24 = u_xlat24 * 1.44269502;
        u_xlat24 = exp2(u_xlat24);
        u_xlat24 = u_xlat24 * 0.25;
        u_xlat24 = u_xlat26 * 0.25 + (-u_xlat24);
        u_xlat24 = u_xlat25 * u_xlat24 + u_xlat0.y;
        u_xlat24 = max(u_xlat24, 0.0);
        u_xlat24 = min(u_xlat24, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat24 = u_xlat0.z * u_xlat25;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat25 = (-u_xlat0.x) + 1.0;
        u_xlat25 = u_xlat25 * 230.831207;
        u_xlat25 = exp2(u_xlat25);
        u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat26 = u_xlat26 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat4.x = u_xlat26 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat26 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat26 * u_xlat4.x + 0.458999991;
        u_xlat26 = u_xlat26 * u_xlat4.x + -0.00286999997;
        u_xlat26 = u_xlat26 * 1.44269502;
        u_xlat26 = exp2(u_xlat26);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat26 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat25 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat25;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat24) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat26 = min(u_xlat2.y, -0.00100000005);
        u_xlat26 = -9.99999975e-05 / u_xlat26;
        u_xlat5.xyz = vec3(u_xlat26) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat21 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat21 = u_xlat5.y * u_xlat21 + 3.82999992;
        u_xlat21 = u_xlat5.y * u_xlat21 + 0.458999991;
        u_xlat13.x = u_xlat5.y * u_xlat21 + -0.00286999997;
        u_xlat13.x = u_xlat13.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat13.x);
        u_xlat21 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat21 = u_xlat5.x * u_xlat21 + 3.82999992;
        u_xlat21 = u_xlat5.x * u_xlat21 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat21 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat13.xz = vec2(u_xlat26) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat13.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat26 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat26 = sqrt(u_xlat26);
        u_xlat26 = (-u_xlat26) + 1.0;
        u_xlat26 = u_xlat26 * 230.831207;
        u_xlat26 = exp2(u_xlat26);
        u_xlat5.x = u_xlat26 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat26 = u_xlat13.z * u_xlat26;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat26);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat26 = u_xlat2.y * -50.0;
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_27 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
    u_xlat16_27 = u_xlat16_27 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD0 = u_xlat26;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
in mediump float vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0 = vs_TEXCOORD0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vec3(vs_TEXCOORD1.x + (-vs_TEXCOORD2.x), vs_TEXCOORD1.y + (-vs_TEXCOORD2.y), vs_TEXCOORD1.z + (-vs_TEXCOORD2.z));
    SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_SUNDISK_SIMPLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat14;
float u_xlat18;
float u_xlat23;
float u_xlat27;
float u_xlat28;
float u_xlat29;
mediump float u_xlat16_30;
float u_xlat31;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
        u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
        u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
        u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
        u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
        u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
        u_xlat9 = u_xlat9 * 1.44269502;
        u_xlat0.y = exp2(u_xlat9);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat27 = sqrt(u_xlat27);
        u_xlat28 = (-u_xlat27) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat27;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat27 = u_xlat31 / u_xlat27;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat27 = (-u_xlat27) + 1.0;
        u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
        u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
        u_xlat27 = u_xlat27 * 1.44269502;
        u_xlat27 = exp2(u_xlat27);
        u_xlat27 = u_xlat27 * 0.25;
        u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
        u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
        u_xlat27 = max(u_xlat27, 0.0);
        u_xlat27 = min(u_xlat27, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat27 = u_xlat0.z * u_xlat28;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat28 = (-u_xlat0.x) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat28;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat29 = min(u_xlat2.y, -0.00100000005);
        u_xlat29 = -9.99999975e-05 / u_xlat29;
        u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
        u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
        u_xlat14.x = u_xlat14.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat14.x);
        u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat29 = u_xlat29 * 230.831207;
        u_xlat29 = exp2(u_xlat29);
        u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat29 = u_xlat14.z * u_xlat29;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_30 = sqrt(u_xlat16_30);
    u_xlat16_30 = max(u_xlat16_30, 0.25);
    u_xlat16_30 = min(u_xlat16_30, 1.0);
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(8000.0, 8000.0, 8000.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_8.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(27.0, 27.0, 27.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
    vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _SunSize;
in mediump vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_3.x = float(1.0) / _SunSize;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_3.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_3.x = vs_TEXCOORD0.y * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.y<0.0);
#else
    u_xlatb2 = vs_TEXCOORD0.y<0.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_SUNDISK_SIMPLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat14;
float u_xlat18;
float u_xlat23;
float u_xlat27;
float u_xlat28;
float u_xlat29;
mediump float u_xlat16_30;
float u_xlat31;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
        u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
        u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
        u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
        u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
        u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
        u_xlat9 = u_xlat9 * 1.44269502;
        u_xlat0.y = exp2(u_xlat9);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat27 = sqrt(u_xlat27);
        u_xlat28 = (-u_xlat27) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat27;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat27 = u_xlat31 / u_xlat27;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat27 = (-u_xlat27) + 1.0;
        u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
        u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
        u_xlat27 = u_xlat27 * 1.44269502;
        u_xlat27 = exp2(u_xlat27);
        u_xlat27 = u_xlat27 * 0.25;
        u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
        u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
        u_xlat27 = max(u_xlat27, 0.0);
        u_xlat27 = min(u_xlat27, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat27 = u_xlat0.z * u_xlat28;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat28 = (-u_xlat0.x) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat28;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat29 = min(u_xlat2.y, -0.00100000005);
        u_xlat29 = -9.99999975e-05 / u_xlat29;
        u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
        u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
        u_xlat14.x = u_xlat14.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat14.x);
        u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat29 = u_xlat29 * 230.831207;
        u_xlat29 = exp2(u_xlat29);
        u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat29 = u_xlat14.z * u_xlat29;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_30 = sqrt(u_xlat16_30);
    u_xlat16_30 = max(u_xlat16_30, 0.25);
    u_xlat16_30 = min(u_xlat16_30, 1.0);
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(8000.0, 8000.0, 8000.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_8.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(27.0, 27.0, 27.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
    vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _SunSize;
in mediump vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_3.x = float(1.0) / _SunSize;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_3.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_3.x = vs_TEXCOORD0.y * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.y<0.0);
#else
    u_xlatb2 = vs_TEXCOORD0.y<0.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_SUNDISK_SIMPLE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat14;
float u_xlat18;
float u_xlat23;
float u_xlat27;
float u_xlat28;
float u_xlat29;
mediump float u_xlat16_30;
float u_xlat31;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
        u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
        u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
        u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
        u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
        u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
        u_xlat9 = u_xlat9 * 1.44269502;
        u_xlat0.y = exp2(u_xlat9);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat27 = sqrt(u_xlat27);
        u_xlat28 = (-u_xlat27) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat27;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat27 = u_xlat31 / u_xlat27;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat27 = (-u_xlat27) + 1.0;
        u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
        u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
        u_xlat27 = u_xlat27 * 1.44269502;
        u_xlat27 = exp2(u_xlat27);
        u_xlat27 = u_xlat27 * 0.25;
        u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
        u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
        u_xlat27 = max(u_xlat27, 0.0);
        u_xlat27 = min(u_xlat27, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat27 = u_xlat0.z * u_xlat28;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat28 = (-u_xlat0.x) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat28;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat29 = min(u_xlat2.y, -0.00100000005);
        u_xlat29 = -9.99999975e-05 / u_xlat29;
        u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
        u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
        u_xlat14.x = u_xlat14.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat14.x);
        u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat29 = u_xlat29 * 230.831207;
        u_xlat29 = exp2(u_xlat29);
        u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat29 = u_xlat14.z * u_xlat29;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_30 = sqrt(u_xlat16_30);
    u_xlat16_30 = max(u_xlat16_30, 0.25);
    u_xlat16_30 = min(u_xlat16_30, 1.0);
    u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(8000.0, 8000.0, 8000.0);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
#else
    u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_8.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(27.0, 27.0, 27.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
    vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	mediump float _SunSize;
in mediump vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
bool u_xlatb2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.xyz = vs_TEXCOORD0.xyz + _WorldSpaceLightPos0.xyz;
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_0.x = sqrt(u_xlat16_0.x);
    u_xlat16_3.x = float(1.0) / _SunSize;
    u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat16_0.x * -2.0 + 3.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_0.x = (-u_xlat16_3.x) * u_xlat16_0.x + 1.0;
    u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
    u_xlat16_3.x = vs_TEXCOORD0.y * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_1.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(vs_TEXCOORD0.y<0.0);
#else
    u_xlatb2 = vs_TEXCOORD0.y<0.0;
#endif
    SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat14;
float u_xlat18;
float u_xlat23;
float u_xlat27;
float u_xlat28;
float u_xlat29;
mediump float u_xlat16_30;
float u_xlat31;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
        u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
        u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
        u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
        u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
        u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
        u_xlat9 = u_xlat9 * 1.44269502;
        u_xlat0.y = exp2(u_xlat9);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat27 = sqrt(u_xlat27);
        u_xlat28 = (-u_xlat27) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat27;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat27 = u_xlat31 / u_xlat27;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat27 = (-u_xlat27) + 1.0;
        u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
        u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
        u_xlat27 = u_xlat27 * 1.44269502;
        u_xlat27 = exp2(u_xlat27);
        u_xlat27 = u_xlat27 * 0.25;
        u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
        u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
        u_xlat27 = max(u_xlat27, 0.0);
        u_xlat27 = min(u_xlat27, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat27 = u_xlat0.z * u_xlat28;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat28 = (-u_xlat0.x) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat28;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat29 = min(u_xlat2.y, -0.00100000005);
        u_xlat29 = -9.99999975e-05 / u_xlat29;
        u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
        u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
        u_xlat14.x = u_xlat14.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat14.x);
        u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat29 = u_xlat29 * 230.831207;
        u_xlat29 = exp2(u_xlat29);
        u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat29 = u_xlat14.z * u_xlat29;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    vs_TEXCOORD0.xyz = (-in_POSITION0.xyz);
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_30 = sqrt(u_xlat16_30);
    u_xlat16_30 = max(u_xlat16_30, 0.25);
    u_xlat16_30 = min(u_xlat16_30, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(15.0, 15.0, 15.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump float _SunSize;
uniform 	mediump float _SunSizeConvergence;
in highp vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
float u_xlat10;
void main()
{
    u_xlat16_0.x = log2(_SunSize);
    u_xlat16_0.x = u_xlat16_0.x * 0.649999976;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _SunSizeConvergence;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_6 = (-u_xlat16_3.x) * 1.98000002 + 1.98010004;
    u_xlat16_0.y = u_xlat16_3.x * u_xlat16_3.x + 1.0;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 0.0100164423);
    u_xlat16_6 = log2(u_xlat16_6);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_0.x = u_xlat16_0.y / u_xlat16_0.x;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.454544991;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_3.x = u_xlat1.y * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.y<0.0);
#else
    u_xlatb1 = u_xlat1.y<0.0;
#endif
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    SV_Target0.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat14;
float u_xlat18;
float u_xlat23;
float u_xlat27;
float u_xlat28;
float u_xlat29;
mediump float u_xlat16_30;
float u_xlat31;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
        u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
        u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
        u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
        u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
        u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
        u_xlat9 = u_xlat9 * 1.44269502;
        u_xlat0.y = exp2(u_xlat9);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat27 = sqrt(u_xlat27);
        u_xlat28 = (-u_xlat27) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat27;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat27 = u_xlat31 / u_xlat27;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat27 = (-u_xlat27) + 1.0;
        u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
        u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
        u_xlat27 = u_xlat27 * 1.44269502;
        u_xlat27 = exp2(u_xlat27);
        u_xlat27 = u_xlat27 * 0.25;
        u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
        u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
        u_xlat27 = max(u_xlat27, 0.0);
        u_xlat27 = min(u_xlat27, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat27 = u_xlat0.z * u_xlat28;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat28 = (-u_xlat0.x) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat28;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat29 = min(u_xlat2.y, -0.00100000005);
        u_xlat29 = -9.99999975e-05 / u_xlat29;
        u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
        u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
        u_xlat14.x = u_xlat14.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat14.x);
        u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat29 = u_xlat29 * 230.831207;
        u_xlat29 = exp2(u_xlat29);
        u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat29 = u_xlat14.z * u_xlat29;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    vs_TEXCOORD0.xyz = (-in_POSITION0.xyz);
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_30 = sqrt(u_xlat16_30);
    u_xlat16_30 = max(u_xlat16_30, 0.25);
    u_xlat16_30 = min(u_xlat16_30, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(15.0, 15.0, 15.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump float _SunSize;
uniform 	mediump float _SunSizeConvergence;
in highp vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
float u_xlat10;
void main()
{
    u_xlat16_0.x = log2(_SunSize);
    u_xlat16_0.x = u_xlat16_0.x * 0.649999976;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _SunSizeConvergence;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_6 = (-u_xlat16_3.x) * 1.98000002 + 1.98010004;
    u_xlat16_0.y = u_xlat16_3.x * u_xlat16_3.x + 1.0;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 0.0100164423);
    u_xlat16_6 = log2(u_xlat16_6);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_0.x = u_xlat16_0.y / u_xlat16_0.x;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.454544991;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_3.x = u_xlat1.y * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.y<0.0);
#else
    u_xlatb1 = u_xlat1.y<0.0;
#endif
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    SV_Target0.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _LightColor0;
uniform 	mediump float _Exposure;
uniform 	mediump vec3 _GroundColor;
uniform 	mediump vec3 _SkyTint;
uniform 	mediump float _AtmosphereThickness;
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
vec4 u_xlat0;
mediump vec3 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec3 u_xlat16_3;
vec3 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
float u_xlat9;
vec3 u_xlat14;
float u_xlat18;
float u_xlat23;
float u_xlat27;
float u_xlat28;
float u_xlat29;
mediump float u_xlat16_30;
float u_xlat31;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
    u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
    u_xlat16_3.x = log2(_AtmosphereThickness);
    u_xlat16_3.x = u_xlat16_3.x * 2.5;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat2.y>=0.0);
#else
    u_xlatb0 = u_xlat2.y>=0.0;
#endif
    if(u_xlatb0){
        u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
        u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
        u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
        u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
        u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
        u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
        u_xlat9 = u_xlat9 * 1.44269502;
        u_xlat0.y = exp2(u_xlat9);
        u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
        u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
        u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat27 = sqrt(u_xlat27);
        u_xlat28 = (-u_xlat27) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat27;
        u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat27 = u_xlat31 / u_xlat27;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat27 = (-u_xlat27) + 1.0;
        u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
        u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
        u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
        u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
        u_xlat27 = u_xlat27 * 1.44269502;
        u_xlat27 = exp2(u_xlat27);
        u_xlat27 = u_xlat27 * 0.25;
        u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
        u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
        u_xlat27 = max(u_xlat27, 0.0);
        u_xlat27 = min(u_xlat27, 50.0);
        u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
        u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat6.xyz = exp2(u_xlat6.xyz);
        u_xlat27 = u_xlat0.z * u_xlat28;
        u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
        u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
        u_xlat0.x = sqrt(u_xlat0.x);
        u_xlat28 = (-u_xlat0.x) + 1.0;
        u_xlat28 = u_xlat28 * 230.831207;
        u_xlat28 = exp2(u_xlat28);
        u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
        u_xlat29 = u_xlat29 / u_xlat0.x;
        u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
        u_xlat0.x = u_xlat4.x / u_xlat0.x;
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
        u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
        u_xlat29 = u_xlat29 * 1.44269502;
        u_xlat29 = exp2(u_xlat29);
        u_xlat0.x = (-u_xlat0.x) + 1.0;
        u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
        u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
        u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
        u_xlat0.x = u_xlat0.x * 1.44269502;
        u_xlat0.x = exp2(u_xlat0.x);
        u_xlat0.x = u_xlat0.x * 0.25;
        u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
        u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
        u_xlat0.x = max(u_xlat0.x, 0.0);
        u_xlat0.x = min(u_xlat0.x, 50.0);
        u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
        u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat4.xyz = exp2(u_xlat4.xyz);
        u_xlat0.x = u_xlat0.z * u_xlat28;
        u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
        u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
        u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
        u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    } else {
        u_xlat29 = min(u_xlat2.y, -0.00100000005);
        u_xlat29 = -9.99999975e-05 / u_xlat29;
        u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
        u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
        u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
        u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
        u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
        u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
        u_xlat14.x = u_xlat14.x * 1.44269502;
        u_xlat5.y = exp2(u_xlat14.x);
        u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
        u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
        u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
        u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
        u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
        u_xlat5.x = exp2(u_xlat5.x);
        u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
        u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
        u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
        u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
        u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
        u_xlat29 = sqrt(u_xlat29);
        u_xlat29 = (-u_xlat29) + 1.0;
        u_xlat29 = u_xlat29 * 230.831207;
        u_xlat29 = exp2(u_xlat29);
        u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
        u_xlat5.x = max(u_xlat5.x, 0.0);
        u_xlat5.x = min(u_xlat5.x, 50.0);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
        u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
        u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
        u_xlat0.xyz = exp2(u_xlat5.xyz);
        u_xlat29 = u_xlat14.z * u_xlat29;
        u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
        u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
        u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
        u_xlat16_4.xyz = u_xlat4.xyz;
        u_xlat16_0.xyz = u_xlat0.xyz;
    //ENDIF
    }
    vs_TEXCOORD0.xyz = (-in_POSITION0.xyz);
    u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
    u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
    u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
    u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
    u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
    u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
    u_xlat16_30 = sqrt(u_xlat16_30);
    u_xlat16_30 = max(u_xlat16_30, 0.25);
    u_xlat16_30 = min(u_xlat16_30, 1.0);
    u_xlat16_0.xyz = u_xlat16_0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
#else
    u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
#endif
    u_xlat16_8.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
    u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(15.0, 15.0, 15.0);
    u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
    vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
    vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
    vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	mediump float _SunSize;
uniform 	mediump float _SunSizeConvergence;
in highp vec3 vs_TEXCOORD0;
in mediump vec3 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec2 u_xlat16_0;
vec3 u_xlat1;
bool u_xlatb1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_6;
float u_xlat10;
void main()
{
    u_xlat16_0.x = log2(_SunSize);
    u_xlat16_0.x = u_xlat16_0.x * 0.649999976;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat1.xyz));
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = log2(u_xlat16_3.x);
    u_xlat16_3.x = u_xlat16_3.x * _SunSizeConvergence;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_6 = (-u_xlat16_3.x) * 1.98000002 + 1.98010004;
    u_xlat16_0.y = u_xlat16_3.x * u_xlat16_3.x + 1.0;
    u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 0.0100164423);
    u_xlat16_6 = log2(u_xlat16_6);
    u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_0.x = max(u_xlat16_0.x, 9.99999975e-05);
    u_xlat16_0.x = u_xlat16_0.y / u_xlat16_0.x;
    u_xlat16_0.x = log2(u_xlat16_0.x);
    u_xlat16_0.x = u_xlat16_0.x * 0.454544991;
    u_xlat16_0.x = exp2(u_xlat16_0.x);
    u_xlat16_3.x = u_xlat1.y * 50.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb1 = !!(u_xlat1.y<0.0);
#else
    u_xlatb1 = u_xlat1.y<0.0;
#endif
    u_xlat16_2.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
    u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vs_TEXCOORD2.xyz;
    u_xlat16_2.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
    SV_Target0.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_SUNDISK_NONE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_SUNDISK_SIMPLE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_SUNDISK_HIGH_QUALITY" }
""
}
}
}
}
CustomEditor "SkyboxProceduralShaderGUI"
}