//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Fire_Grass" {
Properties {
_NoiseTex ("NoiseTexture", 2D) = "white" { }
_ShapeTex ("ShapeTexture", 2D) = "white" { }
_FlowSpeed ("FlowSpeed", Range(0, 1)) = 1
_ColorOut ("ColorOutter", Color) = (1,1,1,1)
_ColorInner ("ColorInner", Color) = (1,1,1,1)
_ColorOutMultiplier ("ColorOutMultiplier", Range(0, 20)) = 10
_ColorInnerMultiplier ("ColorInnerMultiplier", Range(0, 20)) = 10
_NoiseTexBrightness ("NoiseTexBrightness", Range(0, 2)) = 1.22
_NoiseBrightnessAdd ("NoiseBrightnessAdd", Range(-1, 1)) = 0.22
_AlphaAdd ("AlphaAdd", Range(0, 10)) = 1.5
_SwapUV ("SwapUV", Range(-1, 1)) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 30329
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _SwapUV;
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_SwapUV);
#else
    u_xlatb0 = 0.0<_SwapUV;
#endif
    vs_TEXCOORD0.xyz = (bool(u_xlatb0)) ? in_TEXCOORD0.yxz : in_TEXCOORD0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _FlowSpeed;
uniform 	mediump vec4 _ColorOut;
uniform 	mediump vec4 _ColorInner;
uniform 	float _ColorOutMultiplier;
uniform 	float _ColorInnerMultiplier;
uniform 	float _NoiseTexBrightness;
uniform 	float _NoiseBrightnessAdd;
uniform 	float _AlphaAdd;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.y = _FlowSpeed * _Time.y + vs_TEXCOORD0.z;
    u_xlat1.x = 0.0;
    u_xlat0.xy = u_xlat0.xy + (-u_xlat1.xy);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _NoiseTexBrightness + _NoiseBrightnessAdd;
    u_xlat10_3 = texture(_ShapeTex, vs_TEXCOORD0.xy).z;
    u_xlat0.x = u_xlat0.x * u_xlat10_3;
    u_xlat3.x = u_xlat0.x * 0.800000012 + _AlphaAdd;
    u_xlat1.y = (-u_xlat0.x) * 0.800000012 + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat10_0.xzw = texture(_ShapeTex, u_xlat1.xy).xyw;
    u_xlat1.w = u_xlat10_0.z * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorInner.xyz * vec3(vec3(_ColorInnerMultiplier, _ColorInnerMultiplier, _ColorInnerMultiplier));
    u_xlat2.xyz = _ColorOut.xyz * vec3(_ColorOutMultiplier) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	float _SwapUV;
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_SwapUV);
#else
    u_xlatb0 = 0.0<_SwapUV;
#endif
    vs_TEXCOORD0.xyz = (bool(u_xlatb0)) ? in_TEXCOORD0.yxz : in_TEXCOORD0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _FlowSpeed;
uniform 	mediump vec4 _ColorOut;
uniform 	mediump vec4 _ColorInner;
uniform 	float _ColorOutMultiplier;
uniform 	float _ColorInnerMultiplier;
uniform 	float _NoiseTexBrightness;
uniform 	float _NoiseBrightnessAdd;
uniform 	float _AlphaAdd;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.y = _FlowSpeed * _Time.y + vs_TEXCOORD0.z;
    u_xlat1.x = 0.0;
    u_xlat0.xy = u_xlat0.xy + (-u_xlat1.xy);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _NoiseTexBrightness + _NoiseBrightnessAdd;
    u_xlat10_3 = texture(_ShapeTex, vs_TEXCOORD0.xy).z;
    u_xlat0.x = u_xlat0.x * u_xlat10_3;
    u_xlat3.x = u_xlat0.x * 0.800000012 + _AlphaAdd;
    u_xlat1.y = (-u_xlat0.x) * 0.800000012 + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat10_0.xzw = texture(_ShapeTex, u_xlat1.xy).xyw;
    u_xlat1.w = u_xlat10_0.z * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorInner.xyz * vec3(vec3(_ColorInnerMultiplier, _ColorInnerMultiplier, _ColorInnerMultiplier));
    u_xlat2.xyz = _ColorOut.xyz * vec3(_ColorOutMultiplier) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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
uniform 	float _SwapUV;
in highp vec4 in_POSITION0;
in highp vec3 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec3 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<_SwapUV);
#else
    u_xlatb0 = 0.0<_SwapUV;
#endif
    vs_TEXCOORD0.xyz = (bool(u_xlatb0)) ? in_TEXCOORD0.yxz : in_TEXCOORD0.xyz;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _FlowSpeed;
uniform 	mediump vec4 _ColorOut;
uniform 	mediump vec4 _ColorInner;
uniform 	float _ColorOutMultiplier;
uniform 	float _ColorInnerMultiplier;
uniform 	float _NoiseTexBrightness;
uniform 	float _NoiseBrightnessAdd;
uniform 	float _AlphaAdd;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _ShapeTex;
in highp vec3 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
lowp float u_xlat10_3;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.y = _FlowSpeed * _Time.y + vs_TEXCOORD0.z;
    u_xlat1.x = 0.0;
    u_xlat0.xy = u_xlat0.xy + (-u_xlat1.xy);
    u_xlat10_0.x = texture(_NoiseTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0.x * _NoiseTexBrightness + _NoiseBrightnessAdd;
    u_xlat10_3 = texture(_ShapeTex, vs_TEXCOORD0.xy).z;
    u_xlat0.x = u_xlat0.x * u_xlat10_3;
    u_xlat3.x = u_xlat0.x * 0.800000012 + _AlphaAdd;
    u_xlat1.y = (-u_xlat0.x) * 0.800000012 + 1.0;
    u_xlat1.x = vs_TEXCOORD0.x;
    u_xlat10_0.xzw = texture(_ShapeTex, u_xlat1.xy).xyw;
    u_xlat1.w = u_xlat10_0.z * u_xlat3.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.w = min(max(u_xlat1.w, 0.0), 1.0);
#else
    u_xlat1.w = clamp(u_xlat1.w, 0.0, 1.0);
#endif
    u_xlat16_0 = u_xlat10_0.w * u_xlat10_0.w + u_xlat10_0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat3.xyz = _ColorInner.xyz * vec3(vec3(_ColorInnerMultiplier, _ColorInnerMultiplier, _ColorInnerMultiplier));
    u_xlat2.xyz = _ColorOut.xyz * vec3(_ColorOutMultiplier) + (-u_xlat3.xyz);
    u_xlat1.xyz = vec3(u_xlat16_0) * u_xlat2.xyz + u_xlat3.xyz;
    u_xlat0 = u_xlat1 * vs_COLOR0;
    SV_Target0 = u_xlat0;
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