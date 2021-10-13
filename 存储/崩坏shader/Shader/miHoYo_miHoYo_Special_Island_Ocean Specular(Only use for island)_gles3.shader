//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Island/Ocean Specular(Only use for island)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_NormalMap1 ("Normal Map 1", 2D) = "white" { }
_NormalMap2 ("Normal Map 2", 2D) = "white" { }
_BumpVelocity1 ("Bump Velocity 1", Vector) = (0,0,0,0)
_BumpVelocity2 ("Bump Velocity 2", Vector) = (0,0,0,0)
_LightDir1 ("Light Dir 1", Vector) = (0,1,-1,0)
_LightDir2 ("Light Dir 2", Vector) = (0,1,-1,0)
_Shininess1 ("Specular Shininess 1", Float) = 10
_Shininess2 ("Specular Shininess 2", Float) = 10
_SpecularColor ("Specular Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 60297
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _NormalMap1_ST;
uniform 	vec4 _NormalMap2_ST;
uniform 	vec2 _BumpVelocity1;
uniform 	vec2 _BumpVelocity2;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalMap1_ST.xy + _NormalMap1_ST.zw;
    u_xlat1 = _Time.yyyy * vec4(_BumpVelocity1.x, _BumpVelocity1.y, _BumpVelocity2.x, _BumpVelocity2.y);
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat1.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
    vs_TEXCOORD2.xy = vec2(u_xlat1.z + u_xlat0.x, u_xlat1.w + u_xlat0.y);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD3.y = u_xlat16_2.x;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat0.y;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat0.z;
    vs_TEXCOORD5.z = u_xlat0.x;
    vs_TEXCOORD4.y = u_xlat16_2.y;
    vs_TEXCOORD5.y = u_xlat16_2.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec3 _LightDir1;
uniform 	mediump vec3 _LightDir2;
uniform 	mediump float _Shininess1;
uniform 	mediump float _Shininess2;
uniform 	mediump vec3 _SpecularColor;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalMap1;
uniform lowp sampler2D _NormalMap2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.xyz = texture(_NormalMap1, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyz);
    u_xlat16_1.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyz);
    u_xlat16_1.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyz);
    u_xlat10_0.xyz = texture(_NormalMap2, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyz);
    u_xlat16_2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyz);
    u_xlat16_2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    u_xlat16_10 = dot(_LightDir1.xyz, _LightDir1.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat0.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_2.xyz = _LightDir1.xyz * vec3(u_xlat16_10) + u_xlat0.xyz;
    u_xlat16_10 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = vec3(u_xlat16_10) * u_xlat16_2.xyz;
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.00100000005);
    u_xlat16_10 = log2(u_xlat16_10);
    u_xlat16_10 = u_xlat16_10 * _Shininess1;
    u_xlat16_10 = exp2(u_xlat16_10);
    u_xlat16_2.x = dot(_LightDir2.xyz, _LightDir2.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = _LightDir2.xyz * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Shininess2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_10;
    u_xlat16_1.xyz = vec3(u_xlat16_1.x * _SpecularColor.xxyz.y, u_xlat16_1.x * _SpecularColor.xxyz.z, u_xlat16_1.x * float(_SpecularColor.z));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_10 = (-u_xlat10_0.w) + 1.0;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_10) + u_xlat10_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _NormalMap1_ST;
uniform 	vec4 _NormalMap2_ST;
uniform 	vec2 _BumpVelocity1;
uniform 	vec2 _BumpVelocity2;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalMap1_ST.xy + _NormalMap1_ST.zw;
    u_xlat1 = _Time.yyyy * vec4(_BumpVelocity1.x, _BumpVelocity1.y, _BumpVelocity2.x, _BumpVelocity2.y);
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat1.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
    vs_TEXCOORD2.xy = vec2(u_xlat1.z + u_xlat0.x, u_xlat1.w + u_xlat0.y);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD3.y = u_xlat16_2.x;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat0.y;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat0.z;
    vs_TEXCOORD5.z = u_xlat0.x;
    vs_TEXCOORD4.y = u_xlat16_2.y;
    vs_TEXCOORD5.y = u_xlat16_2.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec3 _LightDir1;
uniform 	mediump vec3 _LightDir2;
uniform 	mediump float _Shininess1;
uniform 	mediump float _Shininess2;
uniform 	mediump vec3 _SpecularColor;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalMap1;
uniform lowp sampler2D _NormalMap2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.xyz = texture(_NormalMap1, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyz);
    u_xlat16_1.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyz);
    u_xlat16_1.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyz);
    u_xlat10_0.xyz = texture(_NormalMap2, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyz);
    u_xlat16_2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyz);
    u_xlat16_2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    u_xlat16_10 = dot(_LightDir1.xyz, _LightDir1.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat0.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_2.xyz = _LightDir1.xyz * vec3(u_xlat16_10) + u_xlat0.xyz;
    u_xlat16_10 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = vec3(u_xlat16_10) * u_xlat16_2.xyz;
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.00100000005);
    u_xlat16_10 = log2(u_xlat16_10);
    u_xlat16_10 = u_xlat16_10 * _Shininess1;
    u_xlat16_10 = exp2(u_xlat16_10);
    u_xlat16_2.x = dot(_LightDir2.xyz, _LightDir2.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = _LightDir2.xyz * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Shininess2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_10;
    u_xlat16_1.xyz = vec3(u_xlat16_1.x * _SpecularColor.xxyz.y, u_xlat16_1.x * _SpecularColor.xxyz.z, u_xlat16_1.x * float(_SpecularColor.z));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_10 = (-u_xlat10_0.w) + 1.0;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_10) + u_xlat10_0.xyz;
    SV_Target0.w = _BloomFactor;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 unity_WorldTransformParams;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _NormalMap1_ST;
uniform 	vec4 _NormalMap2_ST;
uniform 	vec2 _BumpVelocity1;
uniform 	vec2 _BumpVelocity2;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out mediump vec3 vs_TEXCOORD3;
out mediump vec3 vs_TEXCOORD4;
out mediump vec3 vs_TEXCOORD5;
out highp vec3 vs_TEXCOORD7;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec3 u_xlat16_2;
float u_xlat9;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
    vs_TEXCOORD7.xyz = u_xlat0.xyz / u_xlat0.www;
    u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalMap1_ST.xy + _NormalMap1_ST.zw;
    u_xlat1 = _Time.yyyy * vec4(_BumpVelocity1.x, _BumpVelocity1.y, _BumpVelocity2.x, _BumpVelocity2.y);
    u_xlat1 = fract(u_xlat1);
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat1.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _NormalMap2_ST.xy + _NormalMap2_ST.zw;
    vs_TEXCOORD2.xy = vec2(u_xlat1.z + u_xlat0.x, u_xlat1.w + u_xlat0.y);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1.xyz = in_TANGENT0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].yzx;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat16_2.xyz);
    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
    u_xlat16_2.xyz = vec3(u_xlat9) * u_xlat16_2.xyz;
    vs_TEXCOORD3.y = u_xlat16_2.x;
    vs_TEXCOORD3.x = u_xlat1.z;
    vs_TEXCOORD3.z = u_xlat0.y;
    vs_TEXCOORD4.x = u_xlat1.x;
    vs_TEXCOORD5.x = u_xlat1.y;
    vs_TEXCOORD4.z = u_xlat0.z;
    vs_TEXCOORD5.z = u_xlat0.x;
    vs_TEXCOORD4.y = u_xlat16_2.y;
    vs_TEXCOORD5.y = u_xlat16_2.z;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	mediump vec3 _LightDir1;
uniform 	mediump vec3 _LightDir2;
uniform 	mediump float _Shininess1;
uniform 	mediump float _Shininess2;
uniform 	mediump vec3 _SpecularColor;
uniform 	float _BloomFactor;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _NormalMap1;
uniform lowp sampler2D _NormalMap2;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in mediump vec3 vs_TEXCOORD3;
in mediump vec3 vs_TEXCOORD4;
in mediump vec3 vs_TEXCOORD5;
in highp vec3 vs_TEXCOORD7;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat9;
mediump float u_xlat16_9;
mediump float u_xlat16_10;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.xyz = texture(_NormalMap1, vs_TEXCOORD1.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_1.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyz);
    u_xlat16_1.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyz);
    u_xlat16_1.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyz);
    u_xlat10_0.xyz = texture(_NormalMap2, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_9 = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
    u_xlat16_9 = inversesqrt(u_xlat16_9);
    u_xlat16_0.xyz = vec3(u_xlat16_9) * u_xlat16_0.xyz;
    u_xlat16_2.x = dot(vs_TEXCOORD3.xyz, u_xlat16_0.xyz);
    u_xlat16_2.y = dot(vs_TEXCOORD4.xyz, u_xlat16_0.xyz);
    u_xlat16_2.z = dot(vs_TEXCOORD5.xyz, u_xlat16_0.xyz);
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_2.xyz;
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_1.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
    u_xlat16_10 = dot(_LightDir1.xyz, _LightDir1.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat0.xyz = (-vs_TEXCOORD7.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat16_2.xyz = _LightDir1.xyz * vec3(u_xlat16_10) + u_xlat0.xyz;
    u_xlat16_10 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = inversesqrt(u_xlat16_10);
    u_xlat16_2.xyz = vec3(u_xlat16_10) * u_xlat16_2.xyz;
    u_xlat16_10 = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_10 = max(u_xlat16_10, 0.00100000005);
    u_xlat16_10 = log2(u_xlat16_10);
    u_xlat16_10 = u_xlat16_10 * _Shininess1;
    u_xlat16_10 = exp2(u_xlat16_10);
    u_xlat16_2.x = dot(_LightDir2.xyz, _LightDir2.xyz);
    u_xlat16_2.x = inversesqrt(u_xlat16_2.x);
    u_xlat16_2.xyz = _LightDir2.xyz * u_xlat16_2.xxx + u_xlat0.xyz;
    u_xlat16_11 = dot(u_xlat16_2.xyz, u_xlat16_2.xyz);
    u_xlat16_11 = inversesqrt(u_xlat16_11);
    u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
    u_xlat16_1.x = dot(u_xlat16_1.xyz, u_xlat16_2.xyz);
    u_xlat16_1.x = max(u_xlat16_1.x, 0.00100000005);
    u_xlat16_1.x = log2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x * _Shininess2;
    u_xlat16_1.x = exp2(u_xlat16_1.x);
    u_xlat16_1.x = u_xlat16_1.x + u_xlat16_10;
    u_xlat16_1.xyz = vec3(u_xlat16_1.x * _SpecularColor.xxyz.y, u_xlat16_1.x * _SpecularColor.xxyz.z, u_xlat16_1.x * float(_SpecularColor.z));
    u_xlat16_1.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_10 = (-u_xlat10_0.w) + 1.0;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(u_xlat16_10) + u_xlat10_0.xyz;
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
}