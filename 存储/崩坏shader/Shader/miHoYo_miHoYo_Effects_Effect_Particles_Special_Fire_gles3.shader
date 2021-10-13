//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Special/Fire" {
Properties {
_ColorInside ("ColorInside", Color) = (0.5,0.5,0.5,0.5)
_ColorOutside ("ColorOutside", Color) = (0.5,0.5,0.5,0.5)
_FireNoise ("Fire Noise", 2D) = "white" { }
_SpeedU ("Speed U", Float) = 0
_SpeedV ("Speed V", Float) = -1
_ShapeMask ("Shape Mask", 2D) = "white" { }
_ShapeBrightness ("Shape Brightness", Float) = 1
_OpacityIntensity ("Opacity Intensity", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Toggle(WRITEDEPTH)] _WriteDepth ("WriteDepth", Float) = 0
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 55634
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _Time;
uniform 	float _EmissionScaler;
uniform 	float _SpeedU;
uniform 	float _SpeedV;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _ShapeMask_ST;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ColorInside;
uniform 	vec4 _ColorOutside;
uniform 	float _OpacityIntensity;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat0.xy = vec2(_SpeedU, _SpeedV) * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_0.x = texture(_FireNoise, u_xlat0.xy).x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_1 = texture(_ShapeMask, u_xlat1.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBrightness;
    u_xlat0.y = (-u_xlat1.x) * u_xlat10_0.x + vs_TEXCOORD0.y;
    u_xlat2 = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0.xyw = texture(_ShapeMask, u_xlat0.xy).xyw;
    SV_Target0.w = u_xlat10_0.y * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInside.xyz) + _ColorOutside.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _ColorInside.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _Time;
uniform 	float _EmissionScaler;
uniform 	float _SpeedU;
uniform 	float _SpeedV;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _ShapeMask_ST;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ColorInside;
uniform 	vec4 _ColorOutside;
uniform 	float _OpacityIntensity;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat0.xy = vec2(_SpeedU, _SpeedV) * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_0.x = texture(_FireNoise, u_xlat0.xy).x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_1 = texture(_ShapeMask, u_xlat1.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBrightness;
    u_xlat0.y = (-u_xlat1.x) * u_xlat10_0.x + vs_TEXCOORD0.y;
    u_xlat2 = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0.xyw = texture(_ShapeMask, u_xlat0.xy).xyw;
    SV_Target0.w = u_xlat10_0.y * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInside.xyz) + _ColorOutside.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _ColorInside.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _Time;
uniform 	float _EmissionScaler;
uniform 	float _SpeedU;
uniform 	float _SpeedV;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _ShapeMask_ST;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ColorInside;
uniform 	vec4 _ColorOutside;
uniform 	float _OpacityIntensity;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
lowp float u_xlat10_1;
float u_xlat2;
void main()
{
    u_xlat0.xy = vec2(_SpeedU, _SpeedV) * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_0.x = texture(_FireNoise, u_xlat0.xy).x;
    u_xlat1.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_1 = texture(_ShapeMask, u_xlat1.xy).z;
    u_xlat1.x = u_xlat10_1 * _ShapeBrightness;
    u_xlat0.y = (-u_xlat1.x) * u_xlat10_0.x + vs_TEXCOORD0.y;
    u_xlat2 = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0.xyw = texture(_ShapeMask, u_xlat0.xy).xyw;
    SV_Target0.w = u_xlat10_0.y * u_xlat2;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat1.xyz = (-_ColorInside.xyz) + _ColorOutside.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat1.xyz + _ColorInside.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(_EmissionScaler);
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _Time;
uniform 	float _EmissionScaler;
uniform 	float _SpeedU;
uniform 	float _SpeedV;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _ShapeMask_ST;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ColorInside;
uniform 	vec4 _ColorOutside;
uniform 	float _OpacityIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp float u_xlat10_2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(_SpeedU, _SpeedV) * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_0.x = texture(_FireNoise, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_2 = texture(_ShapeMask, u_xlat2.xy).z;
    u_xlat2.x = u_xlat10_2 * _ShapeBrightness;
    u_xlat0.y = (-u_xlat2.x) * u_xlat10_0.x + vs_TEXCOORD0.y;
    u_xlat4 = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0.xyw = texture(_ShapeMask, u_xlat0.xy).xyw;
    SV_Target0.w = u_xlat10_0.y * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInside.xyz) + _ColorOutside.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + _ColorInside.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(_EmissionScaler);
    u_xlat6 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _Time;
uniform 	float _EmissionScaler;
uniform 	float _SpeedU;
uniform 	float _SpeedV;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _ShapeMask_ST;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ColorInside;
uniform 	vec4 _ColorOutside;
uniform 	float _OpacityIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp float u_xlat10_2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(_SpeedU, _SpeedV) * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_0.x = texture(_FireNoise, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_2 = texture(_ShapeMask, u_xlat2.xy).z;
    u_xlat2.x = u_xlat10_2 * _ShapeBrightness;
    u_xlat0.y = (-u_xlat2.x) * u_xlat10_0.x + vs_TEXCOORD0.y;
    u_xlat4 = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0.xyw = texture(_ShapeMask, u_xlat0.xy).xyw;
    SV_Target0.w = u_xlat10_0.y * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInside.xyz) + _ColorOutside.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + _ColorInside.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(_EmissionScaler);
    u_xlat6 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	vec4 _Time;
uniform 	float _EmissionScaler;
uniform 	float _SpeedU;
uniform 	float _SpeedV;
uniform 	vec4 _FireNoise_ST;
uniform 	vec4 _ShapeMask_ST;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ColorInside;
uniform 	vec4 _ColorOutside;
uniform 	float _OpacityIntensity;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _FireNoise;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec3 u_xlat2;
lowp float u_xlat10_2;
float u_xlat4;
float u_xlat6;
void main()
{
    u_xlat0.xy = vec2(_SpeedU, _SpeedV) * _Time.yy + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * _FireNoise_ST.xy + _FireNoise_ST.zw;
    u_xlat10_0.x = texture(_FireNoise, u_xlat0.xy).x;
    u_xlat2.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_2 = texture(_ShapeMask, u_xlat2.xy).z;
    u_xlat2.x = u_xlat10_2 * _ShapeBrightness;
    u_xlat0.y = (-u_xlat2.x) * u_xlat10_0.x + vs_TEXCOORD0.y;
    u_xlat4 = u_xlat0.y * _OpacityIntensity;
    u_xlat0.x = vs_TEXCOORD0.x;
    u_xlat0.xy = u_xlat0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0.xyw = texture(_ShapeMask, u_xlat0.xy).xyw;
    SV_Target0.w = u_xlat10_0.y * u_xlat4;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat2.xyz = (-_ColorInside.xyz) + _ColorOutside.xyz;
    u_xlat0.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + _ColorInside.xyz;
    u_xlat1.xyz = u_xlat0.xyz * vec3(_EmissionScaler);
    u_xlat6 = dot(u_xlat1.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(_EmissionScaler) + vec3(u_xlat6);
    u_xlat0.xyz = vec3(_LumiFactor) * u_xlat0.xyz + u_xlat1.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
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
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 77756
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _BloomFactor;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ShapeMask_ST;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0 = texture(_ShapeMask, u_xlat0.xy).z;
    u_xlat1 = u_xlat10_0 * _ShapeBrightness + -0.00999999978;
    u_xlat0.x = u_xlat10_0 * _ShapeBrightness;
    u_xlat0.x = u_xlat0.x * _BloomFactor;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat1<0.0);
#else
    u_xlatb0 = u_xlat1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _BloomFactor;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ShapeMask_ST;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0 = texture(_ShapeMask, u_xlat0.xy).z;
    u_xlat1 = u_xlat10_0 * _ShapeBrightness + -0.00999999978;
    u_xlat0.x = u_xlat10_0 * _ShapeBrightness;
    u_xlat0.x = u_xlat0.x * _BloomFactor;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat1<0.0);
#else
    u_xlatb0 = u_xlat1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
in highp vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
uniform 	float _BloomFactor;
uniform 	float _ShapeBrightness;
uniform 	vec4 _ShapeMask_ST;
uniform lowp sampler2D _ShapeMask;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
float u_xlat1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _ShapeMask_ST.xy + _ShapeMask_ST.zw;
    u_xlat10_0 = texture(_ShapeMask, u_xlat0.xy).z;
    u_xlat1 = u_xlat10_0 * _ShapeBrightness + -0.00999999978;
    u_xlat0.x = u_xlat10_0 * _ShapeBrightness;
    u_xlat0.x = u_xlat0.x * _BloomFactor;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat1<0.0);
#else
    u_xlatb0 = u_xlat1<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = vec3(0.0, 0.0, 0.0);
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}