//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Cloud3D" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_TileSize ("Tile Size", Vector) = (1,1,0,1)
_EmitterWidth ("Emitter Width", Float) = 1
_AspectRatio ("Aspect Ratio", Float) = 1
_BrightColor ("Bright Color", Color) = (1,1,1,1)
_DarkColor ("Dark Color", Color) = (1,1,1,1)
_SecondDarkColor ("Second Dark Color", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_RimShininess ("Rim Shininess", Range(0, 10)) = 1
_RimThreshold ("Rim Threshold", Range(0, 2)) = 0.1
_RimIntensity ("Rim Intensity", Range(0, 2)) = 0
_FlashColor ("Flash Color", Color) = (1,1,1,1)
_FlashAttenFactors ("Flash Attenuation Factors", Vector) = (1,0,0,0)
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 36828
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_11 = u_xlat10_1.z * _RimColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_11 = u_xlat10_1.z * _RimColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _EmissionScaler;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_11 = u_xlat10_1.z * _RimColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_11 = u_xlat10_1.z * _RimColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_1.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_11 = u_xlat10_1.z * _RimColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_1.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec2 in_TEXCOORD0;
out mediump vec3 vs_TEXCOORD0;
out mediump vec3 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * in_NORMAL0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.xxx + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat1.xyz * in_NORMAL0.zzz + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD1.xyz = u_xlat0.xyz;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD2.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _BrightColor;
uniform 	mediump vec4 _DarkColor;
uniform 	mediump vec4 _SecondDarkColor;
uniform 	mediump vec4 _RimColor;
uniform 	mediump float _EmissionScaler;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainTex;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
mediump vec3 u_xlat16_1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump float u_xlat16_9;
mediump float u_xlat16_11;
void main()
{
    u_xlat16_0.xyz = (-_BrightColor.xyz) + _DarkColor.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_9 = u_xlat10_1.x * _DarkColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz + _BrightColor.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _SecondDarkColor.xyz;
    u_xlat16_9 = u_xlat10_1.y * _SecondDarkColor.w;
    u_xlat16_11 = u_xlat10_1.z * _RimColor.w;
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) + _RimColor.xyz;
    u_xlat16_0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz + u_xlat16_0.xyz;
    u_xlat16_2.xyz = u_xlat16_0.xyz * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler));
    u_xlat16_1.x = dot(u_xlat16_2.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_1.xyz = (-u_xlat16_0.xyz) * vec3(vec3(_EmissionScaler, _EmissionScaler, _EmissionScaler)) + u_xlat16_1.xxx;
    u_xlat16_1.xyz = vec3(_LumiFactor) * u_xlat16_1.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz;
    SV_Target0.w = 1.0;
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
}
}
}
}