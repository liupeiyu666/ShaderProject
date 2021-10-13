//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/DLCSmokeSwirlV1" {
Properties {
_MainSmokeTexture ("MainSmokeTexture", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_SmokeBrightness ("SmokeBrightness", Float) = 1
_DisTexture ("DisTexture", 2D) = "white" { }
_DisUvR ("DisUv (R)", Vector) = (0,0,0,0)
_Smoothstep ("Smoothstep", Range(0.5, 1)) = 0.5
_SmoothstepA ("Smoothstep(A)", Range(-1, 1)) = 0
[Toggle(_RIM_SWITCH_ON)] _Rim_Switch ("Rim_Switch", Float) = 0
_Rim ("Rim", Range(-0.1, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,0)
_SwirlTexture ("SwirlTexture", 2D) = "white" { }
_SwirlTexUV ("SwirlTexUV", Vector) = (0,0,0,0)
_SwirlItensity ("SwirlItensity", Float) = 1
[Toggle(_SWIRL_MAINTEX_ON)] _Swirl_MainTex ("Swirl_MainTex", Float) = 0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 2960
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainSmokeTexture_ST;
uniform 	vec2 _SwirlTexUV;
uniform 	vec4 _SwirlTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    u_xlat0.xy = _Time.yy * _SwirlTexUV.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _SwirlTexture_ST.xy + _SwirlTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy + u_xlat4.xy;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Swirl_MainTex;
uniform 	float _Rim_Switch;
uniform 	mediump float _SwirlItensity;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _SwirlTexture;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
mediump vec2 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0.xy = texture(_SwirlTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(_SwirlItensity);
    u_xlat0.xy = vs_TEXCOORD1.zw * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat0.xy = u_xlat16_1.xy * vs_TEXCOORD2.ww + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat16_1.xy * vs_TEXCOORD2.ww;
    u_xlat10_0.x = texture(_DisTexture, u_xlat0.xy).x;
    u_xlatb5.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_Swirl_MainTex, _Rim_Switch, _Swirl_MainTex, _Swirl_MainTex)).xy;
    u_xlat16_1.xy = (u_xlatb5.x) ? u_xlat16_1.xy : vec2(0.0, 0.0);
    u_xlat16_11.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_11.xy;
    u_xlat10_5 = texture(_DisTexture, u_xlat16_1.xy).z;
    u_xlat10_1 = texture(_MainSmokeTexture, u_xlat16_1.xy);
    u_xlat16_2.x = u_xlat10_5 * u_xlat10_0.x + vs_TEXCOORD0.z;
    u_xlat16_7.x = u_xlat16_2.x + vs_TEXCOORD0.w;
    u_xlat16_7.y = u_xlat16_7.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_7.xy = (-vec2(u_xlat16_17)) + u_xlat16_7.xy;
    u_xlat16_3.x = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_7.xy = u_xlat16_7.xy * u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xy = min(max(u_xlat16_7.xy, 0.0), 1.0);
#else
    u_xlat16_7.xy = clamp(u_xlat16_7.xy, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_7.y * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_7.y * u_xlat16_7.y;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat10_1.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_8.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlatb5.y) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xxx * vs_COLOR0.xyz + (-u_xlat16_8.xyz);
    u_xlat16_12 = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_17 = u_xlat16_17 + (-_SmoothstepA);
    u_xlat16_3.x = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.y = _SmoothstepA + _Smoothstep;
    u_xlat16_2.xy = (-vec2(u_xlat16_17)) + u_xlat16_2.xy;
    u_xlat16_7.x = float(1.0) / u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    SV_Target0.w = u_xlat16_2.x * _Opaqueness;
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
uniform 	vec2 _SwirlTexUV;
uniform 	vec4 _SwirlTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    u_xlat0.xy = _Time.yy * _SwirlTexUV.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _SwirlTexture_ST.xy + _SwirlTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy + u_xlat4.xy;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Swirl_MainTex;
uniform 	float _Rim_Switch;
uniform 	mediump float _SwirlItensity;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _SwirlTexture;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
mediump vec2 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0.xy = texture(_SwirlTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(_SwirlItensity);
    u_xlat0.xy = vs_TEXCOORD1.zw * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat0.xy = u_xlat16_1.xy * vs_TEXCOORD2.ww + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat16_1.xy * vs_TEXCOORD2.ww;
    u_xlat10_0.x = texture(_DisTexture, u_xlat0.xy).x;
    u_xlatb5.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_Swirl_MainTex, _Rim_Switch, _Swirl_MainTex, _Swirl_MainTex)).xy;
    u_xlat16_1.xy = (u_xlatb5.x) ? u_xlat16_1.xy : vec2(0.0, 0.0);
    u_xlat16_11.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_11.xy;
    u_xlat10_5 = texture(_DisTexture, u_xlat16_1.xy).z;
    u_xlat10_1 = texture(_MainSmokeTexture, u_xlat16_1.xy);
    u_xlat16_2.x = u_xlat10_5 * u_xlat10_0.x + vs_TEXCOORD0.z;
    u_xlat16_7.x = u_xlat16_2.x + vs_TEXCOORD0.w;
    u_xlat16_7.y = u_xlat16_7.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_7.xy = (-vec2(u_xlat16_17)) + u_xlat16_7.xy;
    u_xlat16_3.x = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_7.xy = u_xlat16_7.xy * u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xy = min(max(u_xlat16_7.xy, 0.0), 1.0);
#else
    u_xlat16_7.xy = clamp(u_xlat16_7.xy, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_7.y * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_7.y * u_xlat16_7.y;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat10_1.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_8.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlatb5.y) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xxx * vs_COLOR0.xyz + (-u_xlat16_8.xyz);
    u_xlat16_12 = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_17 = u_xlat16_17 + (-_SmoothstepA);
    u_xlat16_3.x = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.y = _SmoothstepA + _Smoothstep;
    u_xlat16_2.xy = (-vec2(u_xlat16_17)) + u_xlat16_2.xy;
    u_xlat16_7.x = float(1.0) / u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    SV_Target0.w = u_xlat16_2.x * _Opaqueness;
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
uniform 	vec2 _SwirlTexUV;
uniform 	vec4 _SwirlTexture_ST;
uniform 	vec4 _DisTexture_ST;
uniform 	vec2 _DisUvR;
in highp vec4 in_POSITION0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in mediump vec2 in_TEXCOORD1;
in mediump vec4 in_TEXCOORD2;
out mediump vec4 vs_COLOR0;
out mediump vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out mediump vec4 vs_TEXCOORD2;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainSmokeTexture_ST.xy + _MainSmokeTexture_ST.zw;
    vs_TEXCOORD0.xy = u_xlat0.xy;
    vs_TEXCOORD0.zw = in_TEXCOORD1.xy;
    u_xlat0.xy = _Time.yy * _SwirlTexUV.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _SwirlTexture_ST.xy + _SwirlTexture_ST.zw;
    vs_TEXCOORD1.xy = u_xlat0.xy + u_xlat4.xy;
    u_xlat0.xy = _Time.yy * _DisUvR.xy;
    u_xlat0.xy = fract(u_xlat0.xy);
    u_xlat4.xy = in_TEXCOORD0.xy * _DisTexture_ST.xy + _DisTexture_ST.zw;
    vs_TEXCOORD1.zw = u_xlat0.xy + u_xlat4.xy;
    vs_TEXCOORD2 = in_TEXCOORD2;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _Swirl_MainTex;
uniform 	float _Rim_Switch;
uniform 	mediump float _SwirlItensity;
uniform 	mediump float _Smoothstep;
uniform 	mediump float _SmoothstepA;
uniform 	mediump float _SmokeBrightness;
uniform 	mediump vec3 _RimColor;
uniform 	mediump float _Rim;
uniform 	mediump float _Opaqueness;
uniform lowp sampler2D _SwirlTexture;
uniform lowp sampler2D _MainSmokeTexture;
uniform lowp sampler2D _DisTexture;
in mediump vec4 vs_COLOR0;
in mediump vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in mediump vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec2 u_xlat10_0;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec2 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
lowp float u_xlat10_5;
bvec2 u_xlatb5;
mediump vec2 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec2 u_xlat16_11;
mediump float u_xlat16_12;
mediump float u_xlat16_17;
void main()
{
    u_xlat10_0.xy = texture(_SwirlTexture, vs_TEXCOORD1.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat16_1.xy = u_xlat16_1.xy * vec2(_SwirlItensity);
    u_xlat0.xy = vs_TEXCOORD1.zw * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat0.xy = u_xlat16_1.xy * vs_TEXCOORD2.ww + u_xlat0.xy;
    u_xlat16_1.xy = u_xlat16_1.xy * vs_TEXCOORD2.ww;
    u_xlat10_0.x = texture(_DisTexture, u_xlat0.xy).x;
    u_xlatb5.xy = lessThan(vec4(0.0, 0.0, 0.0, 0.0), vec4(_Swirl_MainTex, _Rim_Switch, _Swirl_MainTex, _Swirl_MainTex)).xy;
    u_xlat16_1.xy = (u_xlatb5.x) ? u_xlat16_1.xy : vec2(0.0, 0.0);
    u_xlat16_11.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
    u_xlat16_1.xy = u_xlat16_1.xy + u_xlat16_11.xy;
    u_xlat10_5 = texture(_DisTexture, u_xlat16_1.xy).z;
    u_xlat10_1 = texture(_MainSmokeTexture, u_xlat16_1.xy);
    u_xlat16_2.x = u_xlat10_5 * u_xlat10_0.x + vs_TEXCOORD0.z;
    u_xlat16_7.x = u_xlat16_2.x + vs_TEXCOORD0.w;
    u_xlat16_7.y = u_xlat16_7.x + _Rim;
    u_xlat16_17 = (-_Smoothstep) + 1.0;
    u_xlat16_7.xy = (-vec2(u_xlat16_17)) + u_xlat16_7.xy;
    u_xlat16_3.x = (-u_xlat16_17) + _Smoothstep;
    u_xlat16_3.x = float(1.0) / u_xlat16_3.x;
    u_xlat16_7.xy = u_xlat16_7.xy * u_xlat16_3.xx;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_7.xy = min(max(u_xlat16_7.xy, 0.0), 1.0);
#else
    u_xlat16_7.xy = clamp(u_xlat16_7.xy, 0.0, 1.0);
#endif
    u_xlat16_8.x = u_xlat16_7.y * -2.0 + 3.0;
    u_xlat16_12 = u_xlat16_7.y * u_xlat16_7.y;
    u_xlat16_12 = u_xlat16_12 * u_xlat16_8.x;
    u_xlat16_8.xyz = u_xlat10_1.zzz * vs_TEXCOORD2.xyz;
    u_xlat16_4.xyz = u_xlat10_1.yyy * vec3(_RimColor.x, _RimColor.y, _RimColor.z) + (-u_xlat16_8.xyz);
    u_xlat16_4.xyz = vec3(u_xlat16_12) * u_xlat16_4.xyz + u_xlat16_8.xyz;
    u_xlat16_8.xyz = (u_xlatb5.y) ? u_xlat16_4.xyz : u_xlat16_8.xyz;
    u_xlat16_4.xyz = u_xlat10_1.xxx * vs_COLOR0.xyz + (-u_xlat16_8.xyz);
    u_xlat16_12 = u_xlat10_1.w * vs_COLOR0.w;
    u_xlat16_17 = u_xlat16_17 + (-_SmoothstepA);
    u_xlat16_3.x = u_xlat16_7.x * -2.0 + 3.0;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_7.x;
    u_xlat16_7.x = u_xlat16_7.x * u_xlat16_3.x;
    u_xlat16_3.xyz = u_xlat16_7.xxx * u_xlat16_4.xyz + u_xlat16_8.xyz;
    SV_Target0.xyz = u_xlat16_3.xyz * vec3(_SmokeBrightness);
    u_xlat16_2.y = _SmoothstepA + _Smoothstep;
    u_xlat16_2.xy = (-vec2(u_xlat16_17)) + u_xlat16_2.xy;
    u_xlat16_7.x = float(1.0) / u_xlat16_2.y;
    u_xlat16_2.x = u_xlat16_7.x * u_xlat16_2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
#else
    u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
#endif
    u_xlat16_7.x = u_xlat16_2.x * -2.0 + 3.0;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_7.x;
    u_xlat16_2.x = u_xlat16_2.x * u_xlat16_12;
    SV_Target0.w = u_xlat16_2.x * _Opaqueness;
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