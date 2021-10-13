//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/EffectFrozen_New" {
Properties {
_SPNCubeMap ("SPNCubeMap", Cube) = "white" { }
_SPNIceBumpTex ("SPNSPNIceBumpTex", 2D) = "white" { }
_SPNCubeMapIndensity ("SPNCubeMapIndensity", Range(0, 1)) = 0.5
_SPNCubeMapBrightNess ("SPNCubeMapBrightNess", Float) = 1.26
_SPNIceDarkColor ("SPNIceDarkColor", Color) = (0.1803922,0.2,0.2117647,0)
_SPNIceLightColor ("SPNIceLightColor", Color) = (0.5529412,0.7058824,0.7803922,0)
_SPNBumpTexIndensity ("SPNBumpTexIndensity", Range(0, 1)) = 1
_SPNIceMaskTex ("SPNIceMaskTex", 2D) = "white" { }
_SPNTillingNormal ("SPNTillingNormal", 2D) = "bump" { }
_SPNNormalIntensity ("SPNNormalIntensity", Vector) = (0.57,0.5,0.81,0)
_SPNBumpOffsetScale ("SPNBumpOffsetScale", Range(-0.5, 0)) = 0
_SPNBumpOffsetHeight ("SPNBumpOffsetHeight", Float) = 0.26
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 46965
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNCubeMapIndensity;
uniform 	float _SPNCubeMapBrightNess;
uniform 	mediump vec4 _SPNIceDarkColor;
uniform 	mediump vec4 _SPNIceLightColor;
uniform 	float _SPNBumpTexIndensity;
uniform 	vec4 _SPNNormalIntensity;
uniform 	float _SPNBumpOffsetScale;
uniform 	float _SPNBumpOffsetHeight;
uniform lowp sampler2D _SPNIceBumpTex;
uniform lowp sampler2D _SPNTillingNormal;
uniform lowp samplerCube _SPNCubeMap;
uniform lowp sampler2D _SPNIceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat10_1.xyz = texture(_SPNTillingNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _SPNNormalIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_SPNCubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = _SPNBumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat12 = _SPNBumpOffsetScale * 0.100000001;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_SPNIceBumpTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_SPNBumpTexIndensity);
    u_xlat16_3.xyz = (-_SPNIceDarkColor.xyz) + _SPNIceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.xyz + _SPNIceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SPNCubeMapBrightNess, _SPNCubeMapBrightNess, _SPNCubeMapBrightNess)) + (-u_xlat1.xyz);
    u_xlat10_12 = texture(_SPNIceMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat12 = u_xlat10_12 * _SPNCubeMapIndensity;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNCubeMapIndensity;
uniform 	float _SPNCubeMapBrightNess;
uniform 	mediump vec4 _SPNIceDarkColor;
uniform 	mediump vec4 _SPNIceLightColor;
uniform 	float _SPNBumpTexIndensity;
uniform 	vec4 _SPNNormalIntensity;
uniform 	float _SPNBumpOffsetScale;
uniform 	float _SPNBumpOffsetHeight;
uniform lowp sampler2D _SPNIceBumpTex;
uniform lowp sampler2D _SPNTillingNormal;
uniform lowp samplerCube _SPNCubeMap;
uniform lowp sampler2D _SPNIceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat10_1.xyz = texture(_SPNTillingNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _SPNNormalIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_SPNCubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = _SPNBumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat12 = _SPNBumpOffsetScale * 0.100000001;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_SPNIceBumpTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_SPNBumpTexIndensity);
    u_xlat16_3.xyz = (-_SPNIceDarkColor.xyz) + _SPNIceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.xyz + _SPNIceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SPNCubeMapBrightNess, _SPNCubeMapBrightNess, _SPNCubeMapBrightNess)) + (-u_xlat1.xyz);
    u_xlat10_12 = texture(_SPNIceMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat12 = u_xlat10_12 * _SPNCubeMapIndensity;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNCubeMapIndensity;
uniform 	float _SPNCubeMapBrightNess;
uniform 	mediump vec4 _SPNIceDarkColor;
uniform 	mediump vec4 _SPNIceLightColor;
uniform 	float _SPNBumpTexIndensity;
uniform 	vec4 _SPNNormalIntensity;
uniform 	float _SPNBumpOffsetScale;
uniform 	float _SPNBumpOffsetHeight;
uniform lowp sampler2D _SPNIceBumpTex;
uniform lowp sampler2D _SPNTillingNormal;
uniform lowp samplerCube _SPNCubeMap;
uniform lowp sampler2D _SPNIceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat10_1.xyz = texture(_SPNTillingNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _SPNNormalIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_SPNCubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = _SPNBumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat12 = _SPNBumpOffsetScale * 0.100000001;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_SPNIceBumpTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_SPNBumpTexIndensity);
    u_xlat16_3.xyz = (-_SPNIceDarkColor.xyz) + _SPNIceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.xyz + _SPNIceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SPNCubeMapBrightNess, _SPNCubeMapBrightNess, _SPNCubeMapBrightNess)) + (-u_xlat1.xyz);
    u_xlat10_12 = texture(_SPNIceMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat12 = u_xlat10_12 * _SPNCubeMapIndensity;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNCubeMapIndensity;
uniform 	float _SPNCubeMapBrightNess;
uniform 	mediump vec4 _SPNIceDarkColor;
uniform 	mediump vec4 _SPNIceLightColor;
uniform 	float _SPNBumpTexIndensity;
uniform 	vec4 _SPNNormalIntensity;
uniform 	float _SPNBumpOffsetScale;
uniform 	float _SPNBumpOffsetHeight;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SPNIceBumpTex;
uniform lowp sampler2D _SPNTillingNormal;
uniform lowp samplerCube _SPNCubeMap;
uniform lowp sampler2D _SPNIceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat10_1.xyz = texture(_SPNTillingNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _SPNNormalIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_SPNCubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = _SPNBumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat12 = _SPNBumpOffsetScale * 0.100000001;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_SPNIceBumpTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_SPNBumpTexIndensity);
    u_xlat16_3.xyz = (-_SPNIceDarkColor.xyz) + _SPNIceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.xyz + _SPNIceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SPNCubeMapBrightNess, _SPNCubeMapBrightNess, _SPNCubeMapBrightNess)) + (-u_xlat1.xyz);
    u_xlat10_12 = texture(_SPNIceMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat12 = u_xlat10_12 * _SPNCubeMapIndensity;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNCubeMapIndensity;
uniform 	float _SPNCubeMapBrightNess;
uniform 	mediump vec4 _SPNIceDarkColor;
uniform 	mediump vec4 _SPNIceLightColor;
uniform 	float _SPNBumpTexIndensity;
uniform 	vec4 _SPNNormalIntensity;
uniform 	float _SPNBumpOffsetScale;
uniform 	float _SPNBumpOffsetHeight;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SPNIceBumpTex;
uniform lowp sampler2D _SPNTillingNormal;
uniform lowp samplerCube _SPNCubeMap;
uniform lowp sampler2D _SPNIceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat10_1.xyz = texture(_SPNTillingNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _SPNNormalIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_SPNCubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = _SPNBumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat12 = _SPNBumpOffsetScale * 0.100000001;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_SPNIceBumpTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_SPNBumpTexIndensity);
    u_xlat16_3.xyz = (-_SPNIceDarkColor.xyz) + _SPNIceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.xyz + _SPNIceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SPNCubeMapBrightNess, _SPNCubeMapBrightNess, _SPNCubeMapBrightNess)) + (-u_xlat1.xyz);
    u_xlat10_12 = texture(_SPNIceMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat12 = u_xlat10_12 * _SPNCubeMapIndensity;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out highp vec4 vs_TEXCOORD5;
out highp vec4 vs_TEXCOORD6;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
float u_xlat9;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD3.w = 0.0;
    u_xlat0.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_TANGENT0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_TANGENT0.zzz + u_xlat0.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD4.xyz = u_xlat0.xyz;
    vs_TEXCOORD4.w = 0.0;
    u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    vs_TEXCOORD5.xyz = u_xlat1.xyz;
    vs_TEXCOORD5.w = 0.0;
    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.zxy;
    u_xlat0.xyz = u_xlat1.yzx * u_xlat0.zxy + (-u_xlat2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    vs_TEXCOORD6.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    vs_TEXCOORD6.w = 0.0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	float _SPNCubeMapIndensity;
uniform 	float _SPNCubeMapBrightNess;
uniform 	mediump vec4 _SPNIceDarkColor;
uniform 	mediump vec4 _SPNIceLightColor;
uniform 	float _SPNBumpTexIndensity;
uniform 	vec4 _SPNNormalIntensity;
uniform 	float _SPNBumpOffsetScale;
uniform 	float _SPNBumpOffsetHeight;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _SPNIceBumpTex;
uniform lowp sampler2D _SPNTillingNormal;
uniform lowp samplerCube _SPNCubeMap;
uniform lowp sampler2D _SPNIceMaskTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in highp vec4 vs_TEXCOORD5;
in highp vec4 vs_TEXCOORD6;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
mediump vec3 u_xlat16_2;
vec3 u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat12;
lowp float u_xlat10_12;
void main()
{
    u_xlat0.x = vs_TEXCOORD4.x;
    u_xlat0.y = vs_TEXCOORD6.x;
    u_xlat0.z = vs_TEXCOORD5.x;
    u_xlat10_1.xyz = texture(_SPNTillingNormal, vs_TEXCOORD0.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_1.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat1.xyz = u_xlat16_2.xyz * _SPNNormalIntensity.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.y;
    u_xlat3.y = vs_TEXCOORD6.y;
    u_xlat3.z = vs_TEXCOORD5.y;
    u_xlat0.y = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat3.x = vs_TEXCOORD4.z;
    u_xlat3.y = vs_TEXCOORD6.z;
    u_xlat3.z = vs_TEXCOORD5.z;
    u_xlat0.z = dot(u_xlat3.xyz, u_xlat1.xyz);
    u_xlat1.xyz = (-vs_TEXCOORD3.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot((-u_xlat1.xyz), u_xlat0.xyz);
    u_xlat12 = u_xlat12 + u_xlat12;
    u_xlat0.xyz = u_xlat0.xyz * (-vec3(u_xlat12)) + (-u_xlat1.xyz);
    u_xlat10_0.xyz = texture(_SPNCubeMap, u_xlat0.xyz).xyz;
    u_xlat12 = _SPNBumpOffsetHeight + -1.0;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12);
    u_xlat12 = _SPNBumpOffsetScale * 0.100000001;
    u_xlat1.xy = u_xlat1.xy * vec2(u_xlat12) + vs_TEXCOORD0.xy;
    u_xlat10_1.xyz = texture(_SPNIceBumpTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(_SPNBumpTexIndensity);
    u_xlat16_3.xyz = (-_SPNIceDarkColor.xyz) + _SPNIceLightColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat16_3.xyz + _SPNIceDarkColor.xyz;
    u_xlat0.xyz = u_xlat10_0.xyz * vec3(vec3(_SPNCubeMapBrightNess, _SPNCubeMapBrightNess, _SPNCubeMapBrightNess)) + (-u_xlat1.xyz);
    u_xlat10_12 = texture(_SPNIceMaskTex, vs_TEXCOORD0.xy).x;
    u_xlat12 = u_xlat10_12 * _SPNCubeMapIndensity;
    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat12 = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(u_xlat12);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
Fallback "Diffuse"
CustomEditor "ASEMaterialInspector"
}