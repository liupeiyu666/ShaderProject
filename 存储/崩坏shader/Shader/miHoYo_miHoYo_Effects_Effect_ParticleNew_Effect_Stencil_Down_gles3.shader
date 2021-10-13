//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Stencil_Down" {
Properties {
_mainColor ("mainColor", Color) = (0.735849,0,0,0)
_MainTex ("MainTex", 2D) = "white" { }
_Stencil ("Stencil Value", Float) = 0
_mainTiling ("mainTiling", Vector) = (0,0,0,0)
_mainSpeed ("mainSpeed", Vector) = (0,0,0,0)
_SecondTex ("SecondTex", 2D) = "white" { }
_SecondTexColor ("SecondTexColor", Color) = (1,1,1,0)
_SecondTexIntensity ("SecondTexIntensity", Float) = 1
_DistortionTex ("DistortionTex", 2D) = "white" { }
_DistortionIntensity ("DistortionIntensity", Float) = 0
_DistortionTilling ("DistortionTilling", Vector) = (1,1,0,0)
_DistortionSpeed ("DistortionSpeed", Vector) = (0,0,0,0)
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  Cull Front
  GpuProgramID 25265
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _mainColor;
uniform 	vec2 _mainSpeed;
uniform 	vec2 _mainTiling;
uniform 	vec4 _SecondTex_ST;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec2 _DistortionSpeed;
uniform 	vec2 _DistortionTilling;
uniform 	float _DistortionIntensity;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortionTilling.xy;
    u_xlat0.xy = _Time.yy * vec2(_DistortionSpeed.x, _DistortionSpeed.y) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortionTex, u_xlat0.xy).xy;
    u_xlat4.xy = vec2(vs_TEXCOORD0.x * float(_mainTiling.x), vs_TEXCOORD0.y * float(_mainTiling.y));
    u_xlat4.xy = _Time.yy * _mainSpeed.xy + u_xlat4.xy;
    u_xlat1.x = _DistortionIntensity * 0.100000001;
    u_xlat0.xy = u_xlat10_0.xy * u_xlat1.xx + u_xlat4.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _SecondTex_ST.xy + _SecondTex_ST.zw;
    u_xlat10_1.xyz = texture(_SecondTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _SecondTexColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_SecondTexIntensity);
    u_xlat0.xyz = _mainColor.xyz * u_xlat10_0.xyz + u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _mainColor;
uniform 	vec2 _mainSpeed;
uniform 	vec2 _mainTiling;
uniform 	vec4 _SecondTex_ST;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec2 _DistortionSpeed;
uniform 	vec2 _DistortionTilling;
uniform 	float _DistortionIntensity;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortionTilling.xy;
    u_xlat0.xy = _Time.yy * vec2(_DistortionSpeed.x, _DistortionSpeed.y) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortionTex, u_xlat0.xy).xy;
    u_xlat4.xy = vec2(vs_TEXCOORD0.x * float(_mainTiling.x), vs_TEXCOORD0.y * float(_mainTiling.y));
    u_xlat4.xy = _Time.yy * _mainSpeed.xy + u_xlat4.xy;
    u_xlat1.x = _DistortionIntensity * 0.100000001;
    u_xlat0.xy = u_xlat10_0.xy * u_xlat1.xx + u_xlat4.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _SecondTex_ST.xy + _SecondTex_ST.zw;
    u_xlat10_1.xyz = texture(_SecondTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _SecondTexColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_SecondTexIntensity);
    u_xlat0.xyz = _mainColor.xyz * u_xlat10_0.xyz + u_xlat1.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
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
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	vec4 _mainColor;
uniform 	vec2 _mainSpeed;
uniform 	vec2 _mainTiling;
uniform 	vec4 _SecondTex_ST;
uniform 	vec4 _SecondTexColor;
uniform 	float _SecondTexIntensity;
uniform 	vec2 _DistortionSpeed;
uniform 	vec2 _DistortionTilling;
uniform 	float _DistortionIntensity;
uniform lowp sampler2D _SecondTex;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _MainTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
lowp vec3 u_xlat10_1;
vec2 u_xlat4;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistortionTilling.xy;
    u_xlat0.xy = _Time.yy * vec2(_DistortionSpeed.x, _DistortionSpeed.y) + u_xlat0.xy;
    u_xlat10_0.xy = texture(_DistortionTex, u_xlat0.xy).xy;
    u_xlat4.xy = vec2(vs_TEXCOORD0.x * float(_mainTiling.x), vs_TEXCOORD0.y * float(_mainTiling.y));
    u_xlat4.xy = _Time.yy * _mainSpeed.xy + u_xlat4.xy;
    u_xlat1.x = _DistortionIntensity * 0.100000001;
    u_xlat0.xy = u_xlat10_0.xy * u_xlat1.xx + u_xlat4.xy;
    u_xlat10_0.xyz = texture(_MainTex, u_xlat0.xy).xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy * _SecondTex_ST.xy + _SecondTex_ST.zw;
    u_xlat10_1.xyz = texture(_SecondTex, u_xlat1.xy).xyz;
    u_xlat1.xyz = u_xlat10_1.xyz * _SecondTexColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_SecondTexIntensity);
    u_xlat0.xyz = _mainColor.xyz * u_xlat10_0.xyz + u_xlat1.xyz;
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
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}