//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_TrailShadow" {
Properties {
_mainColor ("mainColor", Color) = (0.5566038,0.5566038,0.5566038,0)
_Opacity ("Opacity", Float) = 1
_mainTex ("mainTex", 2D) = "white" { }
_MainIntensity ("MainIntensity", Float) = 0
_OffsetDir ("OffsetDir", Vector) = (0,0,0,0)
_OffsetTexture ("OffsetTexture", 2D) = "white" { }
_OffsetIntensity ("OffsetIntensity", Float) = 1
_OffsetNoiseTex ("OffsetNoiseTex", 2D) = "white" { }
_OffsetNoiseSpeed ("OffsetNoiseSpeed", Vector) = (0,0,0,0)
_MaskTex ("MaskTex", 2D) = "white" { }
_MaskSpeed ("MaskSpeed", Vector) = (0,0,0,0)
_DistortionMap ("DistortionMap", 2D) = "bump" { }
_Distortion ("Distortion", Range(0, 1)) = 0.292
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 20624
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OffsetTexture_ST;
uniform 	vec3 _OffsetDir;
uniform 	vec2 _OffsetNoiseSpeed;
uniform 	float _OffsetIntensity;
uniform lowp sampler2D _OffsetTexture;
uniform lowp sampler2D _OffsetNoiseTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _OffsetDir.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _OffsetDir.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _OffsetDir.zzz + u_xlat0.xyz;
    u_xlat1.xy = _Time.yy * _OffsetNoiseSpeed.xy + in_TEXCOORD0.xy;
    u_xlat1.xyz = textureLod(_OffsetNoiseTex, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _OffsetTexture_ST.xy + _OffsetTexture_ST.zw;
    u_xlat1.xyz = textureLod(_OffsetTexture, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_OffsetIntensity, _OffsetIntensity, _OffsetIntensity)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _Opacity;
uniform 	vec2 _MaskSpeed;
uniform 	vec4 _mainColor;
uniform 	vec4 _mainTex_ST;
uniform 	float _MainIntensity;
uniform 	vec4 _DistortionMap_ST;
uniform 	float _Distortion;
uniform lowp sampler2D _DistortionMap;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _mainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat3;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w * 0.5;
    u_xlat3 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat0.y = u_xlat3 * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = vs_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
    u_xlat10_6.xy = texture(_DistortionMap, u_xlat6.xy).xy;
    u_xlat16_1.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_Distortion) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _mainTex_ST.xy + _mainTex_ST.zw;
    u_xlat10_2.xyz = texture(_mainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = _mainColor.xyz * u_xlat10_2.xyz + vec3(_MainIntensity);
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture(_MaskTex, u_xlat0.xy).x;
    SV_Target0.w = u_xlat10_0.x * _Opacity;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OffsetTexture_ST;
uniform 	vec3 _OffsetDir;
uniform 	vec2 _OffsetNoiseSpeed;
uniform 	float _OffsetIntensity;
uniform lowp sampler2D _OffsetTexture;
uniform lowp sampler2D _OffsetNoiseTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _OffsetDir.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _OffsetDir.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _OffsetDir.zzz + u_xlat0.xyz;
    u_xlat1.xy = _Time.yy * _OffsetNoiseSpeed.xy + in_TEXCOORD0.xy;
    u_xlat1.xyz = textureLod(_OffsetNoiseTex, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _OffsetTexture_ST.xy + _OffsetTexture_ST.zw;
    u_xlat1.xyz = textureLod(_OffsetTexture, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_OffsetIntensity, _OffsetIntensity, _OffsetIntensity)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _Opacity;
uniform 	vec2 _MaskSpeed;
uniform 	vec4 _mainColor;
uniform 	vec4 _mainTex_ST;
uniform 	float _MainIntensity;
uniform 	vec4 _DistortionMap_ST;
uniform 	float _Distortion;
uniform lowp sampler2D _DistortionMap;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _mainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat3;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w * 0.5;
    u_xlat3 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat0.y = u_xlat3 * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = vs_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
    u_xlat10_6.xy = texture(_DistortionMap, u_xlat6.xy).xy;
    u_xlat16_1.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_Distortion) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _mainTex_ST.xy + _mainTex_ST.zw;
    u_xlat10_2.xyz = texture(_mainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = _mainColor.xyz * u_xlat10_2.xyz + vec3(_MainIntensity);
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture(_MaskTex, u_xlat0.xy).x;
    SV_Target0.w = u_xlat10_0.x * _Opacity;
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
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _OffsetTexture_ST;
uniform 	vec3 _OffsetDir;
uniform 	vec2 _OffsetNoiseSpeed;
uniform 	float _OffsetIntensity;
uniform lowp sampler2D _OffsetTexture;
uniform lowp sampler2D _OffsetNoiseTex;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * _OffsetDir.yyy;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * _OffsetDir.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * _OffsetDir.zzz + u_xlat0.xyz;
    u_xlat1.xy = _Time.yy * _OffsetNoiseSpeed.xy + in_TEXCOORD0.xy;
    u_xlat1.xyz = textureLod(_OffsetNoiseTex, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat1.xy = in_TEXCOORD0.xy * _OffsetTexture_ST.xy + _OffsetTexture_ST.zw;
    u_xlat1.xyz = textureLod(_OffsetTexture, u_xlat1.xy, 0.0).xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_OffsetIntensity, _OffsetIntensity, _OffsetIntensity)) + in_POSITION0.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	float _Opacity;
uniform 	vec2 _MaskSpeed;
uniform 	vec4 _mainColor;
uniform 	vec4 _mainTex_ST;
uniform 	float _MainIntensity;
uniform 	vec4 _DistortionMap_ST;
uniform 	float _Distortion;
uniform lowp sampler2D _DistortionMap;
uniform lowp sampler2D _BeforeAlphaTexture;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _mainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
mediump vec2 u_xlat16_1;
vec3 u_xlat2;
lowp vec3 u_xlat10_2;
float u_xlat3;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w * 0.5;
    u_xlat3 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat0.y = u_xlat3 * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat6.xy = vs_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
    u_xlat10_6.xy = texture(_DistortionMap, u_xlat6.xy).xy;
    u_xlat16_1.xy = u_xlat10_6.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat0.xy = u_xlat16_1.xy * vec2(_Distortion) + u_xlat0.xy;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat2.xy = vs_TEXCOORD0.xy * _mainTex_ST.xy + _mainTex_ST.zw;
    u_xlat10_2.xyz = texture(_mainTex, u_xlat2.xy).xyz;
    u_xlat2.xyz = _mainColor.xyz * u_xlat10_2.xyz + vec3(_MainIntensity);
    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    u_xlat0.xy = _Time.yy * _MaskSpeed.xy + vs_TEXCOORD0.xy;
    u_xlat10_0.x = texture(_MaskTex, u_xlat0.xy).x;
    SV_Target0.w = u_xlat10_0.x * _Opacity;
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
}
}
}
CustomEditor "ASEMaterialInspector"
}