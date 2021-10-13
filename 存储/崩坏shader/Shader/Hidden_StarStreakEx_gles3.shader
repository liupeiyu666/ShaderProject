//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/StarStreakEx" {
Properties {
_MainTex ("Level0", 2D) = "" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 29232
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float stepSizeX;
uniform 	float stepSizeY;
uniform 	float Stride;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD1.xy = vec2(stepSizeX, stepSizeY) * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(stepSizeX, stepSizeY) + vec2(stepSizeX, stepSizeY);
    vs_TEXCOORD2.xy = u_xlat16_2.xy * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(stepSizeX, stepSizeY) * vec2(3.0, 3.0);
    vs_TEXCOORD3.xy = u_xlat16_2.xy * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 colorCoeff0;
uniform 	mediump vec4 colorCoeff1;
uniform 	mediump vec4 colorCoeff2;
uniform 	mediump vec4 colorCoeff3;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * colorCoeff1;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff0 + u_xlat16_0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff2 + u_xlat16_0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff3 + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
uniform 	float stepSizeX;
uniform 	float stepSizeY;
uniform 	float Stride;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD1.xy = vec2(stepSizeX, stepSizeY) * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(stepSizeX, stepSizeY) + vec2(stepSizeX, stepSizeY);
    vs_TEXCOORD2.xy = u_xlat16_2.xy * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(stepSizeX, stepSizeY) * vec2(3.0, 3.0);
    vs_TEXCOORD3.xy = u_xlat16_2.xy * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 colorCoeff0;
uniform 	mediump vec4 colorCoeff1;
uniform 	mediump vec4 colorCoeff2;
uniform 	mediump vec4 colorCoeff3;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * colorCoeff1;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff0 + u_xlat16_0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff2 + u_xlat16_0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff3 + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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
uniform 	float stepSizeX;
uniform 	float stepSizeY;
uniform 	float Stride;
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec2 u_xlat16_2;
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
    vs_TEXCOORD1.xy = vec2(stepSizeX, stepSizeY) * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(stepSizeX, stepSizeY) + vec2(stepSizeX, stepSizeY);
    vs_TEXCOORD2.xy = u_xlat16_2.xy * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    u_xlat16_2.xy = vec2(stepSizeX, stepSizeY) * vec2(3.0, 3.0);
    vs_TEXCOORD3.xy = u_xlat16_2.xy * vec2(vec2(Stride, Stride)) + in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 colorCoeff0;
uniform 	mediump vec4 colorCoeff1;
uniform 	mediump vec4 colorCoeff2;
uniform 	mediump vec4 colorCoeff3;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD1.xy);
    u_xlat16_0 = u_xlat10_0 * colorCoeff1;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff0 + u_xlat16_0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD2.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff2 + u_xlat16_0;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD3.xy);
    u_xlat16_0 = u_xlat10_1 * colorCoeff3 + u_xlat16_0;
    SV_Target0 = u_xlat16_0;
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