//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Moon Layer" {
Properties {
_MoonTex ("Moon Tex (Alpha)", 2D) = "white" { }
_MoonBumpTex ("Moon Bump", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 4362
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb0 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat6 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb0) ? u_xlat6 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_3.xy = vec2(u_xlat16_0.z * u_xlat16_2.z, u_xlat16_0.w * u_xlat16_2.w);
    u_xlat16_3.xy = u_xlat16_0.xy * u_xlat16_2.xy + (-u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat19 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat19);
    u_xlat5 = cos(u_xlat19);
    u_xlat4.y = (-u_xlat5);
    u_xlat19 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xy = vec2(u_xlat19) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb13 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat19 = u_xlat7 * u_xlat1.x;
    u_xlat19 = u_xlat19 * -2.0 + 3.14159274;
    u_xlat13 = u_xlatb13 ? u_xlat19 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat7 + u_xlat13;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat1.x * 0.636619806;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb0 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat6 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb0) ? u_xlat6 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_3.xy = vec2(u_xlat16_0.z * u_xlat16_2.z, u_xlat16_0.w * u_xlat16_2.w);
    u_xlat16_3.xy = u_xlat16_0.xy * u_xlat16_2.xy + (-u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat19 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat19);
    u_xlat5 = cos(u_xlat19);
    u_xlat4.y = (-u_xlat5);
    u_xlat19 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xy = vec2(u_xlat19) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb13 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat19 = u_xlat7 * u_xlat1.x;
    u_xlat19 = u_xlat19 * -2.0 + 3.14159274;
    u_xlat13 = u_xlatb13 ? u_xlat19 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat7 + u_xlat13;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat1.x * 0.636619806;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb0 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat6 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb0) ? u_xlat6 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_3.xy = vec2(u_xlat16_0.z * u_xlat16_2.z, u_xlat16_0.w * u_xlat16_2.w);
    u_xlat16_3.xy = u_xlat16_0.xy * u_xlat16_2.xy + (-u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat19 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat19);
    u_xlat5 = cos(u_xlat19);
    u_xlat4.y = (-u_xlat5);
    u_xlat19 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xy = vec2(u_xlat19) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb13 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat19 = u_xlat7 * u_xlat1.x;
    u_xlat19 = u_xlat19 * -2.0 + 3.14159274;
    u_xlat13 = u_xlatb13 ? u_xlat19 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat7 + u_xlat13;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat1.x * 0.636619806;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb0 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat6 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb0) ? u_xlat6 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_3.xy = vec2(u_xlat16_0.z * u_xlat16_2.z, u_xlat16_0.w * u_xlat16_2.w);
    u_xlat16_3.xy = u_xlat16_0.xy * u_xlat16_2.xy + (-u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat19 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat19);
    u_xlat5 = cos(u_xlat19);
    u_xlat4.y = (-u_xlat5);
    u_xlat19 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xy = vec2(u_xlat19) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb13 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat19 = u_xlat7 * u_xlat1.x;
    u_xlat19 = u_xlat19 * -2.0 + 3.14159274;
    u_xlat13 = u_xlatb13 ? u_xlat19 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat7 + u_xlat13;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat1.x * 0.636619806;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb0 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat6 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb0) ? u_xlat6 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_3.xy = vec2(u_xlat16_0.z * u_xlat16_2.z, u_xlat16_0.w * u_xlat16_2.w);
    u_xlat16_3.xy = u_xlat16_0.xy * u_xlat16_2.xy + (-u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat19 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat19);
    u_xlat5 = cos(u_xlat19);
    u_xlat4.y = (-u_xlat5);
    u_xlat19 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xy = vec2(u_xlat19) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb13 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat19 = u_xlat7 * u_xlat1.x;
    u_xlat19 = u_xlat19 * -2.0 + 3.14159274;
    u_xlat13 = u_xlatb13 ? u_xlat19 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat7 + u_xlat13;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat1.x * 0.636619806;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec2 u_xlat16_3;
vec2 u_xlat4;
float u_xlat5;
float u_xlat6;
float u_xlat7;
mediump float u_xlat16_9;
float u_xlat13;
bool u_xlatb13;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat16_3.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb0 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat6 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb0) ? u_xlat6 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_0 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_3.xy = vec2(u_xlat16_0.z * u_xlat16_2.z, u_xlat16_0.w * u_xlat16_2.w);
    u_xlat16_3.xy = u_xlat16_0.xy * u_xlat16_2.xy + (-u_xlat16_3.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat19 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat19);
    u_xlat5 = cos(u_xlat19);
    u_xlat4.y = (-u_xlat5);
    u_xlat19 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat4.xy = vec2(u_xlat19) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat19 = inversesqrt(u_xlat19);
    u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat1.x = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat1.x = u_xlat1.x * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat7 = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb13 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat7 = sqrt(u_xlat7);
    u_xlat19 = u_xlat7 * u_xlat1.x;
    u_xlat19 = u_xlat19 * -2.0 + 3.14159274;
    u_xlat13 = u_xlatb13 ? u_xlat19 : float(0.0);
    u_xlat1.x = u_xlat1.x * u_xlat7 + u_xlat13;
    u_xlat1.x = (-u_xlat1.x) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat1.x * 0.636619806;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    SV_TARGET0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec2 u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb18 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat19 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb18) ? u_xlat19 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_15.xy = vec2(u_xlat16_2.z * u_xlat16_3.z, u_xlat16_2.w * u_xlat16_3.w);
    u_xlat16_3.xy = u_xlat16_2.xy * u_xlat16_3.xy + (-u_xlat16_15.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat18 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat18);
    u_xlat5 = cos(u_xlat18);
    u_xlat4.y = (-u_xlat5);
    u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xy = vec2(u_xlat18) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat18 = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb7 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat18 * u_xlat1.x;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat7 = u_xlatb7 ? u_xlat13 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x + u_xlat7;
    u_xlat18 = (-u_xlat18) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat18 * 0.636619806;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColDelta.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    u_xlat16_9 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    SV_TARGET0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_9) + vs_COLOR1.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec2 u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb18 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat19 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb18) ? u_xlat19 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_15.xy = vec2(u_xlat16_2.z * u_xlat16_3.z, u_xlat16_2.w * u_xlat16_3.w);
    u_xlat16_3.xy = u_xlat16_2.xy * u_xlat16_3.xy + (-u_xlat16_15.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat18 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat18);
    u_xlat5 = cos(u_xlat18);
    u_xlat4.y = (-u_xlat5);
    u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xy = vec2(u_xlat18) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat18 = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb7 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat18 * u_xlat1.x;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat7 = u_xlatb7 ? u_xlat13 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x + u_xlat7;
    u_xlat18 = (-u_xlat18) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat18 * 0.636619806;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColDelta.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    u_xlat16_9 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    SV_TARGET0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_9) + vs_COLOR1.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
uniform 	vec4 _HeigtFogParams;
uniform 	vec4 _HeigtFogRamp;
uniform 	vec4 _HeigtFogColBase;
uniform 	vec4 _HeigtFogColDelta;
uniform 	vec4 _HeigtFogColParams;
uniform 	vec4 _HeigtFogRadialCol;
uniform 	vec4 _Mihoyo_FogColor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
float u_xlat5;
float u_xlat6;
bool u_xlatb6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
vec2 u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec2 u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb18 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat19 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb18) ? u_xlat19 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_15.xy = vec2(u_xlat16_2.z * u_xlat16_3.z, u_xlat16_2.w * u_xlat16_3.w);
    u_xlat16_3.xy = u_xlat16_2.xy * u_xlat16_3.xy + (-u_xlat16_15.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat18 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat18);
    u_xlat5 = cos(u_xlat18);
    u_xlat4.y = (-u_xlat5);
    u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xy = vec2(u_xlat18) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat18 = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb7 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat18 * u_xlat1.x;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat7 = u_xlatb7 ? u_xlat13 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x + u_xlat7;
    u_xlat18 = (-u_xlat18) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat18 * 0.636619806;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams.x + _HeigtFogColParams.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat0.xyz = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta.xyz + _HeigtFogColBase.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat6 = u_xlat0.y * _HeigtFogParams.x;
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat12.x = u_xlat0.x + (-_HeigtFogRamp.w);
    u_xlat12.x = u_xlat12.x * _HeigtFogColParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat12.x = min(max(u_xlat12.x, 0.0), 1.0);
#else
    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat12.xxx * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat12.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlat0.x>=u_xlat12.x);
#else
    u_xlatb12 = u_xlat0.x>=u_xlat12.x;
#endif
    u_xlat18 = u_xlat0.x * _HeigtFogParams.z + _HeigtFogParams.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta.w;
    u_xlat12.x = (u_xlatb12) ? u_xlat19 : u_xlat18;
    u_xlat12.x = log2(u_xlat12.x);
    u_xlat12.x = u_xlat12.x * _Mihoyo_FogColor.w;
    u_xlat12.x = exp2(u_xlat12.x);
    u_xlat12.x = min(u_xlat12.x, _HeigtFogColDelta.w);
    u_xlat1.xyz = u_xlat12.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat6 * -1.44269502;
    u_xlat12.y = exp2(u_xlat18);
    u_xlat12.xy = (-u_xlat12.xy) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat12.y / u_xlat6;
#ifdef UNITY_ADRENO_ES3
    u_xlatb6 = !!(0.00999999978<abs(u_xlat6));
#else
    u_xlatb6 = 0.00999999978<abs(u_xlat6);
#endif
    u_xlat16_3.x = (u_xlatb6) ? u_xlat18 : 1.0;
    u_xlat6 = u_xlat0.x * _HeigtFogParams.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp.x + _HeigtFogRamp.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat6 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp.z + (-_HeigtFogRamp.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColDelta.w);
    u_xlat6 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
    u_xlat2.w = u_xlat6 * u_xlat12.x;
    u_xlat2.xyz = _Mihoyo_FogColor.xyz * u_xlat0.xxx + u_xlat1.xyz;
    vs_COLOR1 = u_xlat2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    u_xlat16_9 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    SV_TARGET0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_9) + vs_COLOR1.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec2 u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb18 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat19 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb18) ? u_xlat19 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_15.xy = vec2(u_xlat16_2.z * u_xlat16_3.z, u_xlat16_2.w * u_xlat16_3.w);
    u_xlat16_3.xy = u_xlat16_2.xy * u_xlat16_3.xy + (-u_xlat16_15.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat18 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat18);
    u_xlat5 = cos(u_xlat18);
    u_xlat4.y = (-u_xlat5);
    u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xy = vec2(u_xlat18) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat18 = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb7 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat18 * u_xlat1.x;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat7 = u_xlatb7 ? u_xlat13 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x + u_xlat7;
    u_xlat18 = (-u_xlat18) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat18 * 0.636619806;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat19 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat10.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat19 = min(u_xlat16_3.x, _HeigtFogColDelta3.w);
    u_xlat10.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10.xxx;
    u_xlat2.w = u_xlat18 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_3.x = (-u_xlat6.x) + 2.0;
    u_xlat16_3.x = u_xlat6.x * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_3.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColDelta2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.w = u_xlat12 * u_xlat6.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = u_xlat2 + (-u_xlat3);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    u_xlat16_9 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    SV_TARGET0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_9) + vs_COLOR1.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec2 u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb18 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat19 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb18) ? u_xlat19 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_15.xy = vec2(u_xlat16_2.z * u_xlat16_3.z, u_xlat16_2.w * u_xlat16_3.w);
    u_xlat16_3.xy = u_xlat16_2.xy * u_xlat16_3.xy + (-u_xlat16_15.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat18 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat18);
    u_xlat5 = cos(u_xlat18);
    u_xlat4.y = (-u_xlat5);
    u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xy = vec2(u_xlat18) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat18 = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb7 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat18 * u_xlat1.x;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat7 = u_xlatb7 ? u_xlat13 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x + u_xlat7;
    u_xlat18 = (-u_xlat18) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat18 * 0.636619806;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat19 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat10.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat19 = min(u_xlat16_3.x, _HeigtFogColDelta3.w);
    u_xlat10.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10.xxx;
    u_xlat2.w = u_xlat18 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_3.x = (-u_xlat6.x) + 2.0;
    u_xlat16_3.x = u_xlat6.x * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_3.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColDelta2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.w = u_xlat12 * u_xlat6.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = u_xlat2 + (-u_xlat3);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    u_xlat16_9 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    SV_TARGET0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_9) + vs_COLOR1.xyz;
    SV_TARGET0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec3 _ES_SkyCenterWorldPos;
uniform 	mediump vec3 _ES_SkyWorldUpDir;
uniform 	mediump float _ES_MoonLunarPhase;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in mediump vec3 in_NORMAL0;
in mediump vec4 in_TANGENT0;
out highp vec2 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
bool u_xlatb4;
float u_xlat5;
vec3 u_xlat6;
float u_xlat7;
bool u_xlatb7;
mediump float u_xlat16_9;
vec3 u_xlat10;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec2 u_xlat16_15;
float u_xlat18;
bool u_xlatb18;
float u_xlat19;
bool u_xlatb19;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1].xyww;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0].xyww * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2].xyww * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3].xyww * u_xlat1.wwww + u_xlat2;
    u_xlat1.xyz = u_xlat1.xyz + (-_ES_SkyCenterWorldPos.xyz);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat2.xyz;
    u_xlat2.xyz = _WorldSpaceCameraPos.yyy * hlslcc_mtx4x4unity_WorldToObject[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _WorldSpaceCameraPos.xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _WorldSpaceCameraPos.zzz + u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz + hlslcc_mtx4x4unity_WorldToObject[3].xyz;
    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
    u_xlat16_3.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
#else
    u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_3.x * 3.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(0.0<u_xlat16_3.x);
#else
    u_xlatb18 = 0.0<u_xlat16_3.x;
#endif
    u_xlat16_3.x = u_xlat16_9 * u_xlat16_9;
    u_xlat16_3.x = u_xlat16_3.x * 1.44269502;
    u_xlat16_3.x = exp2(u_xlat16_3.x);
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat19 = (-u_xlat16_3.x) + 1.0;
    vs_TEXCOORD2.w = (u_xlatb18) ? u_xlat19 : 0.0;
    u_xlat16_3.x = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_2 = u_xlat16_3.xxxx * in_NORMAL0.yxzy;
    u_xlat16_3.x = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat16_3.x = inversesqrt(u_xlat16_3.x);
    u_xlat16_3 = u_xlat16_3.xxxx * in_TANGENT0.zyyx;
    u_xlat16_15.xy = vec2(u_xlat16_2.z * u_xlat16_3.z, u_xlat16_2.w * u_xlat16_3.w);
    u_xlat16_3.xy = u_xlat16_2.xy * u_xlat16_3.xy + (-u_xlat16_15.xy);
    u_xlat16_3.xy = u_xlat16_3.xy * in_TANGENT0.ww;
    u_xlat18 = _ES_MoonLunarPhase * 6.28318548;
    u_xlat4.x = sin(u_xlat18);
    u_xlat5 = cos(u_xlat18);
    u_xlat4.y = (-u_xlat5);
    u_xlat18 = dot(u_xlat4.xy, u_xlat4.xy);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat4.xy = vec2(u_xlat18) * u_xlat4.xy;
    vs_TEXCOORD2.y = dot(u_xlat16_3.xy, u_xlat4.xy);
    vs_TEXCOORD2.x = dot(in_TANGENT0.xz, u_xlat4.xy);
    vs_TEXCOORD2.z = dot(in_NORMAL0.xz, u_xlat4.xy);
    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat18 = inversesqrt(u_xlat18);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat16_3.x = dot(_ES_SkyWorldUpDir.xyz, u_xlat1.xyz);
    vs_TEXCOORD4.xyz = u_xlat1.xyz;
    u_xlat18 = abs(u_xlat16_3.x) * -0.0187292993 + 0.0742610022;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + -0.212114394;
    u_xlat18 = u_xlat18 * abs(u_xlat16_3.x) + 1.57072878;
    u_xlat1.x = -abs(u_xlat16_3.x) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb7 = !!(u_xlat16_3.x<(-u_xlat16_3.x));
#else
    u_xlatb7 = u_xlat16_3.x<(-u_xlat16_3.x);
#endif
    u_xlat1.x = sqrt(u_xlat1.x);
    u_xlat13 = u_xlat18 * u_xlat1.x;
    u_xlat13 = u_xlat13 * -2.0 + 3.14159274;
    u_xlat7 = u_xlatb7 ? u_xlat13 : float(0.0);
    u_xlat18 = u_xlat18 * u_xlat1.x + u_xlat7;
    u_xlat18 = (-u_xlat18) + 1.57079637;
    vs_TEXCOORD4.w = u_xlat18 * 0.636619806;
    u_xlat18 = u_xlat0.y * _HeigtFogColParams3.x + _HeigtFogColParams3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat16_3.x = (-u_xlat18) + 2.0;
    u_xlat16_3.x = u_xlat18 * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta3.xyz + _HeigtFogColBase3.xyz;
    u_xlat4.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol3.xyz;
    u_xlat0.xzw = u_xlat0.xyz + (-_WorldSpaceCameraPos.xyz);
    u_xlat6.x = u_xlat0.y * _HeigtFogColParams2.x + _HeigtFogColParams2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat0.x = dot(u_xlat0.xzw, u_xlat0.xzw);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat18 = u_xlat0.x + (-_HeigtFogRamp3.w);
    u_xlat18 = u_xlat18 * _HeigtFogColParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz + u_xlat1.xyz;
    u_xlat18 = u_xlat0.x * _HeigtFogParams3.z + _HeigtFogParams3.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat18 = min(max(u_xlat18, 0.0), 1.0);
#else
    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
#endif
    u_xlat19 = (-u_xlat18) + 2.0;
    u_xlat18 = u_xlat18 * u_xlat19;
    u_xlat19 = u_xlat18 * _HeigtFogColDelta3.w;
    u_xlat4.x = _ProjectionParams.z * 0.999899983;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x>=u_xlat4.x);
#else
    u_xlatb4 = u_xlat0.x>=u_xlat4.x;
#endif
    u_xlat18 = (u_xlatb4) ? u_xlat19 : u_xlat18;
    u_xlat18 = log2(u_xlat18);
    u_xlat18 = u_xlat18 * _Mihoyo_FogColor3.w;
    u_xlat18 = exp2(u_xlat18);
    u_xlat18 = min(u_xlat18, _HeigtFogColDelta3.w);
    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
    u_xlat18 = (-u_xlat18) + 1.0;
    u_xlat19 = u_xlat0.z * _HeigtFogParams3.x;
    u_xlat12 = u_xlat0.z * _HeigtFogParams2.x;
    u_xlat10.x = u_xlat19 * -1.44269502;
    u_xlat10.x = exp2(u_xlat10.x);
    u_xlat10.x = (-u_xlat10.x) + 1.0;
    u_xlat10.x = u_xlat10.x / u_xlat19;
#ifdef UNITY_ADRENO_ES3
    u_xlatb19 = !!(0.00999999978<abs(u_xlat19));
#else
    u_xlatb19 = 0.00999999978<abs(u_xlat19);
#endif
    u_xlat16_3.x = (u_xlatb19) ? u_xlat10.x : 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogParams3.y;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat19 = u_xlat0.x * _HeigtFogRamp3.x + _HeigtFogRamp3.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat19 = min(max(u_xlat19, 0.0), 1.0);
#else
    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
#endif
    u_xlat16_9 = (-u_xlat19) + 2.0;
    u_xlat16_9 = u_xlat19 * u_xlat16_9;
    u_xlat19 = u_xlat16_9 * _HeigtFogRamp3.z + (-_HeigtFogRamp3.z);
    u_xlat19 = u_xlat19 + 1.0;
    u_xlat16_3.x = u_xlat19 * u_xlat16_3.x;
    u_xlat19 = min(u_xlat16_3.x, _HeigtFogColDelta3.w);
    u_xlat10.x = (-u_xlat19) + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat10.xxx;
    u_xlat2.w = u_xlat18 * u_xlat10.x;
    u_xlat2.xyz = _Mihoyo_FogColor3.xyz * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat16_3.x = (-u_xlat6.x) + 2.0;
    u_xlat16_3.x = u_xlat6.x * u_xlat16_3.x;
    u_xlat1.xyz = u_xlat16_3.xxx * _HeigtFogColDelta2.xyz + _HeigtFogColBase2.xyz;
    u_xlat10.xyz = (-u_xlat1.xyz) + _HeigtFogRadialCol2.xyz;
    u_xlat6.x = u_xlat0.x + (-_HeigtFogRamp2.w);
    u_xlat6.x = u_xlat6.x * _HeigtFogColParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat6.xxx * u_xlat10.xyz + u_xlat1.xyz;
    u_xlat6.x = u_xlat0.x * _HeigtFogParams2.z + _HeigtFogParams2.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
#else
    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
#endif
    u_xlat18 = (-u_xlat6.x) + 2.0;
    u_xlat6.x = u_xlat18 * u_xlat6.x;
    u_xlat18 = u_xlat6.x * _HeigtFogColDelta2.w;
    u_xlat6.x = (u_xlatb4) ? u_xlat18 : u_xlat6.x;
    u_xlat6.x = log2(u_xlat6.x);
    u_xlat6.x = u_xlat6.x * _Mihoyo_FogColor2.w;
    u_xlat6.x = exp2(u_xlat6.x);
    u_xlat6.x = min(u_xlat6.x, _HeigtFogColDelta2.w);
    u_xlat1.xyz = u_xlat6.xxx * u_xlat1.xyz;
    u_xlat18 = u_xlat12 * -1.44269502;
    u_xlat6.z = exp2(u_xlat18);
    u_xlat6.xz = (-u_xlat6.xz) + vec2(1.0, 1.0);
    u_xlat18 = u_xlat6.z / u_xlat12;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(0.00999999978<abs(u_xlat12));
#else
    u_xlatb12 = 0.00999999978<abs(u_xlat12);
#endif
    u_xlat16_3.x = (u_xlatb12) ? u_xlat18 : 1.0;
    u_xlat12 = u_xlat0.x * _HeigtFogParams2.y;
    u_xlat0.x = u_xlat0.x * _HeigtFogRamp2.x + _HeigtFogRamp2.y;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat16_3.x = u_xlat12 * u_xlat16_3.x;
    u_xlat16_3.x = exp2((-u_xlat16_3.x));
    u_xlat16_3.x = min(u_xlat16_3.x, 1.0);
    u_xlat16_3.x = (-u_xlat16_3.x) + 1.0;
    u_xlat16_9 = (-u_xlat0.x) + 2.0;
    u_xlat16_9 = u_xlat0.x * u_xlat16_9;
    u_xlat0.x = u_xlat16_9 * _HeigtFogRamp2.z + (-_HeigtFogRamp2.z);
    u_xlat0.x = u_xlat0.x + 1.0;
    u_xlat16_3.x = u_xlat0.x * u_xlat16_3.x;
    u_xlat0.x = min(u_xlat16_3.x, _HeigtFogColDelta2.w);
    u_xlat12 = (-u_xlat0.x) + 1.0;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat3.w = u_xlat12 * u_xlat6.x;
    u_xlat3.xyz = _Mihoyo_FogColor2.xyz * u_xlat0.xxx + u_xlat1.xyz;
    u_xlat0 = u_xlat2 + (-u_xlat3);
    u_xlat0 = vec4(vec4(_LerpFactor, _LerpFactor, _LerpFactor, _LerpFactor)) * u_xlat0 + u_xlat3;
    vs_COLOR1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec3 _ES_MoonColor;
uniform 	mediump float _ES_MoonBrightness;
uniform lowp sampler2D _MoonBumpTex;
uniform lowp sampler2D _MoonTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD2;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_TARGET0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_9;
void main()
{
    u_xlat16_0.x = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
    u_xlat16_0.x = inversesqrt(u_xlat16_0.x);
    u_xlat16_0.xyz = u_xlat16_0.xxx * vs_TEXCOORD2.xyz;
    u_xlat10_1.xyz = texture(_MoonBumpTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_2.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
#else
    u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
#endif
    u_xlat10_1.x = texture(_MoonTex, vs_TEXCOORD0.xy).w;
    u_xlat16_3.xyz = u_xlat10_1.xxx * _ES_MoonColor.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(vec3(_ES_MoonBrightness, _ES_MoonBrightness, _ES_MoonBrightness));
    u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vs_TEXCOORD2.www;
    u_xlat16_9 = vs_COLOR1.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_9 = min(max(u_xlat16_9, 0.0), 1.0);
#else
    u_xlat16_9 = clamp(u_xlat16_9, 0.0, 1.0);
#endif
    SV_TARGET0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_9) + vs_COLOR1.xyz;
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
}
}
}
}