//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/BlackWhite_New" {
Properties {
_Desaturate ("Desaturate", Range(0, 1)) = 0
_MainColor ("MainColor", Color) = (1,1,1,0)
_Min ("Min", Float) = 0
_Max ("Max", Float) = 1
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 1
[Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
[Toggle(_ParticleCT)] _ParticleCT ("Custom Data", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 18729
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _Min;
uniform 	mediump float _Max;
uniform 	mediump float _ParticleCT;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
bvec2 u_xlatb7;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w * 0.5;
    u_xlat3 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat0.y = u_xlat3 * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat16_9 = dot(u_xlat10_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_9);
    u_xlat9 = vs_TEXCOORD1.z + _Desaturate;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy + vec2(_Min, _Max);
    u_xlatb7.xy = equal(vec4(vec4(_ParticleCT, _ParticleCT, _ParticleCT, _ParticleCT)), vec4(1.0, 0.0, 1.0, 0.0)).xy;
    u_xlat16_2.xy = (u_xlatb7.y) ? vec2(_Min, _Max) : vec2(0.0, 0.0);
    u_xlat16_2.xy = (u_xlatb7.x) ? u_xlat1.xy : u_xlat16_2.xy;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_2.xxx);
    u_xlat16_9 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat0.xyz = vec3(u_xlat16_9) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * vec3(-2.0, -2.0, -2.0) + vec3(3.0, 3.0, 3.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = vs_COLOR0.w;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _Min;
uniform 	mediump float _Max;
uniform 	mediump float _ParticleCT;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
bvec2 u_xlatb7;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w * 0.5;
    u_xlat3 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat0.y = u_xlat3 * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat16_9 = dot(u_xlat10_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_9);
    u_xlat9 = vs_TEXCOORD1.z + _Desaturate;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy + vec2(_Min, _Max);
    u_xlatb7.xy = equal(vec4(vec4(_ParticleCT, _ParticleCT, _ParticleCT, _ParticleCT)), vec4(1.0, 0.0, 1.0, 0.0)).xy;
    u_xlat16_2.xy = (u_xlatb7.y) ? vec2(_Min, _Max) : vec2(0.0, 0.0);
    u_xlat16_2.xy = (u_xlatb7.x) ? u_xlat1.xy : u_xlat16_2.xy;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_2.xxx);
    u_xlat16_9 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat0.xyz = vec3(u_xlat16_9) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * vec3(-2.0, -2.0, -2.0) + vec3(3.0, 3.0, 3.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = vs_COLOR0.w;
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

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD3;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0 = in_TEXCOORD0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD3.zw = u_xlat0.zw;
    vs_TEXCOORD3.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1 = in_TEXCOORD1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ProjectionParams;
uniform 	mediump float _Min;
uniform 	mediump float _Max;
uniform 	mediump float _ParticleCT;
uniform 	mediump float _Desaturate;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _BeforeAlphaTexture;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec3 u_xlat0;
lowp vec3 u_xlat10_0;
vec3 u_xlat1;
mediump vec3 u_xlat16_1;
mediump vec3 u_xlat16_2;
float u_xlat3;
bvec2 u_xlatb7;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.x = vs_TEXCOORD3.w * 0.5;
    u_xlat3 = (-vs_TEXCOORD3.w) * 0.5 + vs_TEXCOORD3.y;
    u_xlat0.y = u_xlat3 * _ProjectionParams.x + u_xlat0.x;
    u_xlat0.x = vs_TEXCOORD3.x;
    u_xlat0.xy = u_xlat0.xy / vs_TEXCOORD3.ww;
    u_xlat10_0.xyz = texture(_BeforeAlphaTexture, u_xlat0.xy).xyz;
    u_xlat16_9 = dot(u_xlat10_0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat16_1.xyz = (-u_xlat10_0.xyz) + vec3(u_xlat16_9);
    u_xlat9 = vs_TEXCOORD1.z + _Desaturate;
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat16_1.xyz + u_xlat10_0.xyz;
    u_xlat1.xy = vs_TEXCOORD1.xy + vec2(_Min, _Max);
    u_xlatb7.xy = equal(vec4(vec4(_ParticleCT, _ParticleCT, _ParticleCT, _ParticleCT)), vec4(1.0, 0.0, 1.0, 0.0)).xy;
    u_xlat16_2.xy = (u_xlatb7.y) ? vec2(_Min, _Max) : vec2(0.0, 0.0);
    u_xlat16_2.xy = (u_xlatb7.x) ? u_xlat1.xy : u_xlat16_2.xy;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat16_2.xxx);
    u_xlat16_9 = (-u_xlat16_2.x) + u_xlat16_2.y;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat0.xyz = vec3(u_xlat16_9) * u_xlat0.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xyz = min(max(u_xlat0.xyz, 0.0), 1.0);
#else
    u_xlat0.xyz = clamp(u_xlat0.xyz, 0.0, 1.0);
#endif
    u_xlat1.xyz = u_xlat0.xyz * vec3(-2.0, -2.0, -2.0) + vec3(3.0, 3.0, 3.0);
    u_xlat0.xyz = u_xlat0.xyz * u_xlat0.xyz;
    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
    u_xlat16_2.xyz = u_xlat0.xyz * _MainColor.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat0.xyz;
    SV_Target0.w = vs_COLOR0.w;
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}