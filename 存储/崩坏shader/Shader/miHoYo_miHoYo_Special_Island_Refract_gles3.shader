//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Island/Refract" {
Properties {
_CausticColor ("Caustic Color", Color) = (1,0,0,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Speed ("Speed", Range(0.001, 2)) = 0.5
_Frequency ("Frequency", Range(1, 200)) = 20
_Delta ("Delta", Range(0, 0.1)) = 0.01
_PhaseOffset ("PhaseOffset", Range(0, 6)) = 0
_CausticScale ("CausticScale", Range(0, 10)) = 3
_MainIntensity ("MainIntensity", Range(0, 1)) = 1
_CausticIntensity ("CausticIntensity", Range(0, 5)) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_CausticTex ("CausticMap (RGB)", 2D) = "black" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 33834
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR1 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta;
uniform 	float _PhaseOffset;
uniform 	float _CausticScale;
uniform 	float _MainIntensity;
uniform 	float _CausticIntensity;
uniform 	vec4 _CausticColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _CausticTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Frequency, _Frequency)) + vec2(_PhaseOffset);
    u_xlat0.xy = cos(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Delta, _Delta)) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_CausticScale, _CausticScale));
    u_xlat10_0 = texture(_CausticTex, u_xlat0.xy).y;
    u_xlat0.xyz = vec3(u_xlat10_0) * _CausticColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_CausticIntensity, _CausticIntensity, _CausticIntensity));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR1.www;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(vec3(_MainIntensity, _MainIntensity, _MainIntensity));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR1 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta;
uniform 	float _PhaseOffset;
uniform 	float _CausticScale;
uniform 	float _MainIntensity;
uniform 	float _CausticIntensity;
uniform 	vec4 _CausticColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _CausticTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Frequency, _Frequency)) + vec2(_PhaseOffset);
    u_xlat0.xy = cos(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Delta, _Delta)) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_CausticScale, _CausticScale));
    u_xlat10_0 = texture(_CausticTex, u_xlat0.xy).y;
    u_xlat0.xyz = vec3(u_xlat10_0) * _CausticColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_CausticIntensity, _CausticIntensity, _CausticIntensity));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR1.www;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(vec3(_MainIntensity, _MainIntensity, _MainIntensity));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_COLOR0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR1;
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
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_COLOR1 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _LightMapIntensity;
uniform 	mediump float _BloomFactor;
uniform 	float _Speed;
uniform 	float _Frequency;
uniform 	float _Delta;
uniform 	float _PhaseOffset;
uniform 	float _CausticScale;
uniform 	float _MainIntensity;
uniform 	float _CausticIntensity;
uniform 	vec4 _CausticColor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ShadowTex;
uniform lowp sampler2D _CausticTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp float u_xlat10_0;
vec3 u_xlat1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_Speed) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Frequency, _Frequency)) + vec2(_PhaseOffset);
    u_xlat0.xy = cos(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Delta, _Delta)) + vs_TEXCOORD0.xy;
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_CausticScale, _CausticScale));
    u_xlat10_0 = texture(_CausticTex, u_xlat0.xy).y;
    u_xlat0.xyz = vec3(u_xlat10_0) * _CausticColor.xyz;
    u_xlat0.xyz = u_xlat0.xyz * vec3(vec3(_CausticIntensity, _CausticIntensity, _CausticIntensity));
    u_xlat0.xyz = u_xlat0.xyz * vs_COLOR1.www;
    u_xlat10_1 = texture(_ShadowTex, vs_TEXCOORD1.xy);
    u_xlat16_2.xyz = u_xlat10_1.xyz + u_xlat10_1.xyz;
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat10_1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_2.xyz = (-u_xlat10_1.www) + u_xlat16_2.xyz;
    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * vec3(vec3(_MainIntensity, _MainIntensity, _MainIntensity));
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vec3(_LightMapIntensity) + u_xlat0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = _BloomFactor;
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
}