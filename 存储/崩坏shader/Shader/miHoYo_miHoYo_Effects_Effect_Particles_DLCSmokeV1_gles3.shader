//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/DLCSmokeV1" {
Properties {
_MainSmokeTexture ("MainSmokeTexture", 2D) = "white" { }
_SmokeBrightness ("SmokeBrightness", Float) = 1
_DisTexture ("DisTexture", 2D) = "white" { }
_DisUvR ("DisUv (R)", Vector) = (0,0,1,1)
[Toggle(_DISTEXG_SWITCH_ON)] _DisTexG_Switch ("DisTex(G)_Switch", Float) = 0
_DisUvG ("DisUv(G)", Vector) = (0,0,1,1)
_Smoothstep ("Smoothstep", Range(0.5, 1)) = 0.5
_SmoothstepA ("Smoothstep(A)", Range(-1, 1)) = 0
[Toggle(_RIM_SWITCH_ON)] _Rim_Switch ("Rim_Switch", Float) = 0
_Rim ("Rim", Range(-1, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,0)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Render Options)] [Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 4947
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
Keywords { "LUMINANCE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
Keywords { "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
Keywords { "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat10_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_DISTEXG_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat16_0 + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
Keywords { "_DISTEXG_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat16_0 + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
Keywords { "_DISTEXG_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat16_0 + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat16_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat16_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump float u_xlat16_5;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1 = u_xlat10_4 * u_xlat16_0.x + vs_TEXCOORD1.x;
    u_xlat16_5 = u_xlat16_1 + vs_TEXCOORD1.y;
    u_xlat16_9 = (-_Smoothstep) + 1.0;
    u_xlat16_5 = (-u_xlat16_9) + u_xlat16_5;
    u_xlat16_13 = (-u_xlat16_9) + _Smoothstep;
    u_xlat16_9 = u_xlat16_9 + (-_SmoothstepA);
    u_xlat16_13 = float(1.0) / u_xlat16_13;
    u_xlat16_5 = u_xlat16_13 * u_xlat16_5;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5 = min(max(u_xlat16_5, 0.0), 1.0);
#else
    u_xlat16_5 = clamp(u_xlat16_5, 0.0, 1.0);
#endif
    u_xlat16_13 = u_xlat16_5 * -2.0 + 3.0;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_5;
    u_xlat16_5 = u_xlat16_5 * u_xlat16_13;
    u_xlat10_0.xyz = texture(_MainSmokeTexture, vs_TEXCOORD1.zw).xzw;
    u_xlat16_2.xyz = u_xlat10_0.yyy * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_2.xyz);
    u_xlat16_2.xyz = vec3(u_xlat16_5) * u_xlat16_3.xyz + u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat10_0.z * vs_COLOR0.w;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1 = (-u_xlat16_9) + u_xlat16_1;
    u_xlat16_13 = _SmoothstepA + _Smoothstep;
    u_xlat16_9 = (-u_xlat16_9) + u_xlat16_13;
    u_xlat16_9 = float(1.0) / u_xlat16_9;
    u_xlat16_1 = u_xlat16_9 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_9 = u_xlat16_1 * -2.0 + 3.0;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_1;
    u_xlat16_1 = u_xlat16_1 * u_xlat16_9;
    SV_Target0.w = u_xlat16_1 * u_xlat16_5;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat16_0 + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat16_0 + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump float u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0 = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat16_0 + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    SV_Target0.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat16_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat16_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
uniform 	vec4 _DisUvG;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec3 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out mediump vec4 vs_TEXCOORD1;
out mediump vec3 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat4;
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
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD0.zw = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvG.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    vs_TEXCOORD0.xy = u_xlat4.xy * _DisUvG.zw + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xyz = in_TEXCOORD2.xyz;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _LumiFactor;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in mediump vec4 vs_TEXCOORD1;
in mediump vec3 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
lowp float u_xlat10_4;
mediump vec2 u_xlat16_5;
mediump vec3 u_xlat16_6;
mediump float u_xlat16_9;
mediump float u_xlat16_13;
void main()
{
    u_xlat10_0.x = texture(_DisTexture, vs_TEXCOORD0.zw).x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD0.xy).y;
    u_xlat16_0.x = u_xlat10_4 + u_xlat10_0.x;
    u_xlat10_4 = texture(_DisTexture, vs_TEXCOORD1.zw).z;
    u_xlat16_1.x = u_xlat10_4 * u_xlat16_0.x + vs_TEXCOORD1.x;
    u_xlat16_5.x = u_xlat16_1.x + vs_TEXCOORD1.y;
    u_xlat16_5.y = u_xlat16_5.x + _Rim;
    u_xlat16_13 = (-_Smoothstep) + 1.0;
    u_xlat16_5.xy = (-vec2(u_xlat16_13)) + u_xlat16_5.xy;
    u_xlat16_2.x = (-u_xlat16_13) + _Smoothstep;
    u_xlat16_2.x = float(1.0) / u_xlat16_2.x;
    u_xlat16_5.xy = u_xlat16_5.xy * u_xlat16_2.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_5.xy = min(max(u_xlat16_5.xy, 0.0), 1.0);
#else
    u_xlat16_5.xy = clamp(u_xlat16_5.xy, 0.0, 1.0);
#endif
    u_xlat16_6.x = u_xlat16_5.y * -2.0 + 3.0;
    u_xlat16_9 = u_xlat16_5.y * u_xlat16_5.y;
    u_xlat16_9 = u_xlat16_9 * u_xlat16_6.x;
    u_xlat10_0 = texture(_MainSmokeTexture, vs_TEXCOORD1.zw);
    u_xlat16_6.xyz = u_xlat10_0.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_3.xyz = u_xlat10_0.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = vec3(u_xlat16_9) * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat10_0.xxx * vs_COLOR0.xyz + (-u_xlat16_6.xyz);
    u_xlat16_9 = u_xlat10_0.w * vs_COLOR0.w;
    u_xlat16_13 = u_xlat16_13 + (-_SmoothstepA);
    u_xlat16_2.x = u_xlat16_5.x * -2.0 + 3.0;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_5.x;
    u_xlat16_5.x = u_xlat16_5.x * u_xlat16_2.x;
    u_xlat16_2.xyz = u_xlat16_5.xxx * u_xlat16_3.xyz + u_xlat16_6.xyz;
    u_xlat16_3.xyz = u_xlat16_2.xyz * vec3(_SmokeBrightness);
    u_xlat16_0.x = dot(u_xlat16_3.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat16_0.xyz = (-vec3(_SmokeBrightness)) * u_xlat16_2.xyz + u_xlat16_0.xxx;
    u_xlat16_0.xyz = vec3(vec3(_LumiFactor, _LumiFactor, _LumiFactor)) * u_xlat16_0.xyz + u_xlat16_3.xyz;
    SV_Target0.xyz = u_xlat16_0.xyz;
    u_xlat16_1.y = _SmoothstepA + _Smoothstep;
    u_xlat16_1.xy = (-vec2(u_xlat16_13)) + u_xlat16_1.xy;
    u_xlat16_5.x = float(1.0) / u_xlat16_1.y;
    u_xlat16_1.x = u_xlat16_5.x * u_xlat16_1.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_5.x = u_xlat16_1.x * -2.0 + 3.0;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_1.x;
    u_xlat16_1.x = u_xlat16_1.x * u_xlat16_5.x;
    SV_Target0.w = u_xlat16_1.x * u_xlat16_9;
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
SubProgram "gles3 hw_tier00 " {
Keywords { "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}