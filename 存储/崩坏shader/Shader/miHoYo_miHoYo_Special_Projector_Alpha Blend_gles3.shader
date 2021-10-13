//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Projector/Alpha Blend" {
Properties {
_MainColor ("Main Color", Color) = (0.05,0.24,0.35,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 0.75
_Cookie ("Cookie", 2D) = "white" { }
_FalloffTex ("FallOff", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent" }
  ZWrite Off
  Offset -1, -1
  GpuProgramID 30284
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 hlslcc_mtx4x4unity_Projector[4];
uniform 	vec4 hlslcc_mtx4x4unity_ProjectorClip[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_Projector[1];
    u_xlat0 = hlslcc_mtx4x4unity_Projector[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_Projector[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_Projector[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ProjectorClip[1];
    u_xlat0 = hlslcc_mtx4x4unity_ProjectorClip[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ProjectorClip[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ProjectorClip[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Opaqueness;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _Cookie;
uniform lowp sampler2D _FalloffTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_0 = texture(_Cookie, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_0 + -1.0;
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture(_FalloffTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1 + 1.0;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0.x = u_xlat16_1 * _Opaqueness + -0.00999999978;
    u_xlat16_1 = u_xlat16_1 * _Opaqueness;
    SV_Target0.w = u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = _MainColor.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_Projector[4];
uniform 	vec4 hlslcc_mtx4x4unity_ProjectorClip[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_Projector[1];
    u_xlat0 = hlslcc_mtx4x4unity_Projector[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_Projector[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_Projector[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ProjectorClip[1];
    u_xlat0 = hlslcc_mtx4x4unity_ProjectorClip[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ProjectorClip[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ProjectorClip[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Opaqueness;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _Cookie;
uniform lowp sampler2D _FalloffTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_0 = texture(_Cookie, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_0 + -1.0;
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture(_FalloffTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1 + 1.0;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0.x = u_xlat16_1 * _Opaqueness + -0.00999999978;
    u_xlat16_1 = u_xlat16_1 * _Opaqueness;
    SV_Target0.w = u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = _MainColor.xyz;
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
uniform 	vec4 hlslcc_mtx4x4unity_Projector[4];
uniform 	vec4 hlslcc_mtx4x4unity_ProjectorClip[4];
in highp vec4 in_POSITION0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_Projector[1];
    u_xlat0 = hlslcc_mtx4x4unity_Projector[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_Projector[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD0 = hlslcc_mtx4x4unity_Projector[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ProjectorClip[1];
    u_xlat0 = hlslcc_mtx4x4unity_ProjectorClip[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ProjectorClip[2] * in_POSITION0.zzzz + u_xlat0;
    vs_TEXCOORD1 = hlslcc_mtx4x4unity_ProjectorClip[3] * in_POSITION0.wwww + u_xlat0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _Opaqueness;
uniform 	mediump vec4 _MainColor;
uniform lowp sampler2D _Cookie;
uniform lowp sampler2D _FalloffTex;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp float u_xlat10_0;
bool u_xlatb0;
mediump float u_xlat16_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
    u_xlat10_0 = texture(_Cookie, u_xlat0.xy).x;
    u_xlat16_1 = u_xlat10_0 + -1.0;
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture(_FalloffTex, u_xlat0.xy).w;
    u_xlat16_1 = u_xlat10_0 * u_xlat16_1 + 1.0;
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat0.x = u_xlat16_1 * _Opaqueness + -0.00999999978;
    u_xlat16_1 = u_xlat16_1 * _Opaqueness;
    SV_Target0.w = u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    SV_Target0.w = min(max(SV_Target0.w, 0.0), 1.0);
#else
    SV_Target0.w = clamp(SV_Target0.w, 0.0, 1.0);
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
    SV_Target0.xyz = _MainColor.xyz;
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