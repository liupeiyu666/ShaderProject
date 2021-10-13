//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/LightningShell" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler To Add", Range(1, 100)) = 1
_NoiseTex ("Noise Tex", 2D) = "white" { }
_NoiseScaler ("Noise Scaler", Range(0, 10)) = 1
_Transition ("Transition", Range(0, 1)) = 0
_Displacement ("Displacement", Range(0, 0.1)) = 0
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 40596
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _NoiseTex_ST;
uniform 	float _Displacement;
in highp vec4 in_POSITION0;
in highp vec3 in_TANGENT0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_TANGENT0.xyzz * vec4(vec4(_Displacement, _Displacement, _Displacement, _Displacement)) + in_POSITION0.xyzz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    u_xlat0.xy = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _NoiseScaler;
uniform 	float _Transition;
uniform 	mediump vec4 _Color;
uniform 	float _EmissionScaler;
uniform 	float _BloomFactor;
uniform lowp sampler2D _NoiseTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_NoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat10_0 * 1.99000001;
    u_xlat0 = u_xlat16_1 * _NoiseScaler + -1.0;
    u_xlat3.x = _NoiseScaler * _Transition;
    u_xlat6 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat3.x = u_xlat6 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _Color.xyz * vec3(_EmissionScaler);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    SV_Target0.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    SV_Target0.w = (u_xlati0 != 0) ? 0.0 : _BloomFactor;
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
uniform 	vec4 _NoiseTex_ST;
uniform 	float _Displacement;
in highp vec4 in_POSITION0;
in highp vec3 in_TANGENT0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_TANGENT0.xyzz * vec4(vec4(_Displacement, _Displacement, _Displacement, _Displacement)) + in_POSITION0.xyzz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    u_xlat0.xy = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _NoiseScaler;
uniform 	float _Transition;
uniform 	mediump vec4 _Color;
uniform 	float _EmissionScaler;
uniform 	float _BloomFactor;
uniform lowp sampler2D _NoiseTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_NoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat10_0 * 1.99000001;
    u_xlat0 = u_xlat16_1 * _NoiseScaler + -1.0;
    u_xlat3.x = _NoiseScaler * _Transition;
    u_xlat6 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat3.x = u_xlat6 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _Color.xyz * vec3(_EmissionScaler);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    SV_Target0.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    SV_Target0.w = (u_xlati0 != 0) ? 0.0 : _BloomFactor;
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
uniform 	vec4 _NoiseTex_ST;
uniform 	float _Displacement;
in highp vec4 in_POSITION0;
in highp vec3 in_TANGENT0;
out mediump vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
void main()
{
    u_xlat0 = in_TANGENT0.xyzz * vec4(vec4(_Displacement, _Displacement, _Displacement, _Displacement)) + in_POSITION0.xyzz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.wwww + u_xlat1;
    u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    u_xlat1 = u_xlat0 * vec4(0.5, 0.5, 0.5, 0.25);
    u_xlat0.x = u_xlat0.x * u_xlat1.x;
    u_xlat3 = u_xlat1.w + u_xlat1.y;
    u_xlat1.x = u_xlat1.z * u_xlat1.z + u_xlat1.x;
    u_xlat1.y = u_xlat0.x * 0.25 + u_xlat3;
    u_xlat0.xy = u_xlat1.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _NoiseScaler;
uniform 	float _Transition;
uniform 	mediump vec4 _Color;
uniform 	float _EmissionScaler;
uniform 	float _BloomFactor;
uniform lowp sampler2D _NoiseTex;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
float u_xlat0;
lowp float u_xlat10_0;
int u_xlati0;
mediump float u_xlat16_1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture(_NoiseTex, vs_TEXCOORD0.xy).x;
    u_xlat16_1 = u_xlat10_0 * 1.99000001;
    u_xlat0 = u_xlat16_1 * _NoiseScaler + -1.0;
    u_xlat3.x = _NoiseScaler * _Transition;
    u_xlat6 = u_xlat3.x * 1.70000005 + (-u_xlat0);
    u_xlat0 = u_xlat3.x * 1.5 + (-u_xlat0);
    u_xlat0 = u_xlat0 + 1.0;
    u_xlat0 = floor(u_xlat0);
    u_xlat0 = max(u_xlat0, 0.0);
    u_xlati0 = int(u_xlat0);
    u_xlat3.x = u_xlat6 * 10.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat2.xyz = _Color.xyz * vec3(_EmissionScaler);
    u_xlat3.xyz = u_xlat3.xxx * u_xlat2.xyz;
    SV_Target0.xyz = (int(u_xlati0) != 0) ? vec3(0.0, 0.0, 0.0) : u_xlat3.xyz;
    SV_Target0.w = (u_xlati0 != 0) ? 0.0 : _BloomFactor;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}