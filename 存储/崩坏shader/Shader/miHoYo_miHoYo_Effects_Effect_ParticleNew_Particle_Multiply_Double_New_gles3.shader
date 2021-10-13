//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Particle_Multiply_Double_New" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 16143
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TSAspectRatio;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
int u_xlati1;
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
    u_xlat0.xy = in_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat1.x = float(1.0);
    u_xlat1.w = float(1.0);
    u_xlat1.y = _TSAspectRatio;
    u_xlat1.z = float(1.0) / _TSAspectRatio;
    u_xlat0 = u_xlat0.xyxy * u_xlat1;
    u_xlat1.x = (-_TSAspectRatio) + 2.0;
    u_xlat1.x = floor(u_xlat1.x);
    u_xlat1.x = max(u_xlat1.x, 0.0);
    u_xlati1 = int(u_xlat1.x);
    u_xlat0.xy = (int(u_xlati1) != 0) ? u_xlat0.zw : u_xlat0.xy;
    u_xlat0.xy = u_xlat0.xy + vec2(0.5, 0.5);
    vs_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    u_xlat0.x = 0.0;
    u_xlat0.zw = _MainTex_ST.xy;
    vs_TEXCOORD1 = vec4(u_xlat0.x + _MainTex_ST.z, u_xlat0.x + _MainTex_ST.w, u_xlat0.z + _MainTex_ST.z, u_xlat0.w + _MainTex_ST.w);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
int u_xlati0;
mediump vec4 u_xlat16_1;
void main()
{
    u_xlat0 = vs_TEXCOORD0.x + (-vs_TEXCOORD1.x);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = vs_TEXCOORD0.y + (-vs_TEXCOORD1.y);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.x) + vs_TEXCOORD1.z;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat0 = (-vs_TEXCOORD0.y) + vs_TEXCOORD1.w;
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    if((u_xlati0)==0){discard;}
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_0 * vs_COLOR0;
    u_xlat16_1.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat16_1 = u_xlat16_0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat16_0 = u_xlat16_0.wwww * u_xlat16_1 + vec4(0.5, 0.5, 0.5, 0.5);
    SV_Target0.w = u_xlat16_0.w;
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
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "TEXTURE_SCALE" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}