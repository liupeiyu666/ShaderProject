//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Billboard/Light Beam" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_MainTex_Alpha ("Particle Texture Alpha", 2D) = "white" { }
_DustTex ("Second Texture", 2D) = "black" { }
_DustTex_Alpha ("Second Texture Alpha", 2D) = "white" { }
_DustIntensity ("Dust Intensity", Float) = 1
_DustSpeed ("Dust Speed", Float) = 0
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 41027
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _DustTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat10_0 = texture(_DustTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * vec4(_DustIntensity);
    u_xlat16_1 = _TintColor + _TintColor;
    u_xlat16_1 = u_xlat16_1 * vs_COLOR0;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat10_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat2.w = u_xlat16_1.w * u_xlat10_2.w + u_xlat16_0.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).x;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).y;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DustIntensity;
uniform 	mediump float _EmissionScaler;
uniform 	mediump vec4 _TintColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _MainTex_Alpha;
uniform lowp sampler2D _DustTex;
uniform lowp sampler2D _DustTex_Alpha;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_13;
void main()
{
    u_xlat0.xyz = texture(_DustTex, vs_TEXCOORD1.xy).xyz;
    u_xlat0.w = texture(_DustTex_Alpha, vs_TEXCOORD1.xy).z;
    u_xlat16_0 = u_xlat0 * vec4(_DustIntensity);
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2 = _TintColor + _TintColor;
    u_xlat16_2 = u_xlat16_2 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_3.x = dot(u_xlat16_3.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
    u_xlat16_0 = u_xlat16_0 * u_xlat16_3.xxxx;
    u_xlat10_13 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    SV_Target0.w = u_xlat16_2.w * u_xlat10_13 + u_xlat16_0.w;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_0.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
 Pass {
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 96132
Program "vp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).x;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).y;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DustTex_ST;
uniform 	float _DustSpeed;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat2;
float u_xlat4;
void main()
{
    u_xlat0.xy = _WorldSpaceCameraPos.yy * hlslcc_mtx4x4unity_WorldToObject[1].xz;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[0].xz * _WorldSpaceCameraPos.xx + u_xlat0.xy;
    u_xlat0.xy = hlslcc_mtx4x4unity_WorldToObject[2].xz * _WorldSpaceCameraPos.zz + u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToObject[3].xz;
    u_xlat4 = dot((-u_xlat0.xy), (-u_xlat0.xy));
    u_xlat4 = inversesqrt(u_xlat4);
    u_xlat0.xy = vec2(u_xlat4) * (-u_xlat0.xy);
    u_xlat4 = u_xlat0.x * in_POSITION0.z;
    u_xlat4 = in_POSITION0.x * (-u_xlat0.y) + u_xlat4;
    u_xlat0.x = dot(in_POSITION0.xz, u_xlat0.xy);
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat4) + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = _Time.x * _DustSpeed;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat2.xy = in_TEXCOORD0.xy * _DustTex_ST.xy + _DustTex_ST.zw;
    vs_TEXCOORD1.y = u_xlat0.x + u_xlat2.y;
    vs_TEXCOORD1.x = u_xlat2.x;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _BloomFactor;
uniform lowp sampler2D _MainTex_Alpha;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
void main()
{
    u_xlat10_0 = texture(_MainTex_Alpha, vs_TEXCOORD0.xy).z;
    u_xlat0 = u_xlat10_0 + 0.99000001;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_ORIG" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_R" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_G" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ALPHA_B" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ShaderEditorBase"
}