//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilter" {
Properties {
_MainTex ("Base (RGB)", 2D) = "" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 2135
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0159309991, -0.0159309991, -0.00269700005, -0.00269700005) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.68936801, 0.68936801, 0.68936801, 0.68936801);
    u_xlat16_0 = u_xlat10_0 * vec4(0.0363150015, 0.0363150015, 0.0363150015, 0.0363150015) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.0088109998, 0.0088109998, 0.0234379992, 0.0234379992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.272895008, 0.272895008, 0.272895008, 0.272895008) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.001422, 0.001422, 0.001422, 0.001422) + u_xlat16_0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0159309991, -0.0159309991, -0.00269700005, -0.00269700005) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.68936801, 0.68936801, 0.68936801, 0.68936801);
    u_xlat16_0 = u_xlat10_0 * vec4(0.0363150015, 0.0363150015, 0.0363150015, 0.0363150015) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.0088109998, 0.0088109998, 0.0234379992, 0.0234379992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.272895008, 0.272895008, 0.272895008, 0.272895008) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.001422, 0.001422, 0.001422, 0.001422) + u_xlat16_0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0159309991, -0.0159309991, -0.00269700005, -0.00269700005) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.68936801, 0.68936801, 0.68936801, 0.68936801);
    u_xlat16_0 = u_xlat10_0 * vec4(0.0363150015, 0.0363150015, 0.0363150015, 0.0363150015) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.0088109998, 0.0088109998, 0.0234379992, 0.0234379992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.272895008, 0.272895008, 0.272895008, 0.272895008) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.001422, 0.001422, 0.001422, 0.001422) + u_xlat16_0;
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
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 125232
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0796450004, -0.0796450004, -0.049922999, -0.049922999) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0509780012, 0.0509780012, 0.0509780012, 0.0509780012);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00178000005, 0.00178000005, 0.00178000005, 0.00178000005) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0211350005, -0.0211350005, 0.00702399993, 0.00702399993) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.32029599, 0.32029599, 0.32029599, 0.32029599) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.46124199, 0.46124199, 0.46124199, 0.46124199) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0354139991, 0.0354139991, 0.0646739975, 0.0646739975) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.153980002, 0.153980002, 0.153980002, 0.153980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0115499999, 0.0115499999, 0.0115499999, 0.0115499999) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.09375, 0.09375) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000172999993, 0.000172999993, 0.000172999993, 0.000172999993) + u_xlat16_0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0796450004, -0.0796450004, -0.049922999, -0.049922999) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0509780012, 0.0509780012, 0.0509780012, 0.0509780012);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00178000005, 0.00178000005, 0.00178000005, 0.00178000005) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0211350005, -0.0211350005, 0.00702399993, 0.00702399993) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.32029599, 0.32029599, 0.32029599, 0.32029599) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.46124199, 0.46124199, 0.46124199, 0.46124199) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0354139991, 0.0354139991, 0.0646739975, 0.0646739975) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.153980002, 0.153980002, 0.153980002, 0.153980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0115499999, 0.0115499999, 0.0115499999, 0.0115499999) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.09375, 0.09375) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000172999993, 0.000172999993, 0.000172999993, 0.000172999993) + u_xlat16_0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.0796450004, -0.0796450004, -0.049922999, -0.049922999) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0509780012, 0.0509780012, 0.0509780012, 0.0509780012);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00178000005, 0.00178000005, 0.00178000005, 0.00178000005) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0211350005, -0.0211350005, 0.00702399993, 0.00702399993) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.32029599, 0.32029599, 0.32029599, 0.32029599) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.46124199, 0.46124199, 0.46124199, 0.46124199) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0354139991, 0.0354139991, 0.0646739975, 0.0646739975) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.153980002, 0.153980002, 0.153980002, 0.153980002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0115499999, 0.0115499999, 0.0115499999, 0.0115499999) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.09375, 0.09375) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000172999993, 0.000172999993, 0.000172999993, 0.000172999993) + u_xlat16_0;
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
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 155074
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.254662991, -0.254662991, -0.194030002, -0.194030002) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00571999978, 0.00571999978, 0.00571999978, 0.00571999978);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000302, 0.000302, 0.000302, 0.000302) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.133894995, -0.133894995, -0.074210003, -0.074210003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0490350015, 0.0490350015, 0.0490350015, 0.0490350015) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.191699997, 0.191699997, 0.191699997, 0.191699997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0148259997, -0.0148259997, 0.0444939993, 0.0444939993) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.343513995, 0.343513995, 0.343513995, 0.343513995) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.28283599, 0.28283599, 0.28283599, 0.28283599) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.104002997, 0.104002997, 0.163901001, 0.163901001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.106913, 0.106913, 0.106913, 0.106913) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0184819996, 0.0184819996, 0.0184819996, 0.0184819996) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.224285007, 0.224285007, 0.28125, 0.28125) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.001453, 0.001453, 0.001453, 0.001453) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(4.50000007e-05, 4.50000007e-05, 4.50000007e-05, 4.50000007e-05) + u_xlat16_0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.254662991, -0.254662991, -0.194030002, -0.194030002) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00571999978, 0.00571999978, 0.00571999978, 0.00571999978);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000302, 0.000302, 0.000302, 0.000302) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.133894995, -0.133894995, -0.074210003, -0.074210003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0490350015, 0.0490350015, 0.0490350015, 0.0490350015) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.191699997, 0.191699997, 0.191699997, 0.191699997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0148259997, -0.0148259997, 0.0444939993, 0.0444939993) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.343513995, 0.343513995, 0.343513995, 0.343513995) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.28283599, 0.28283599, 0.28283599, 0.28283599) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.104002997, 0.104002997, 0.163901001, 0.163901001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.106913, 0.106913, 0.106913, 0.106913) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0184819996, 0.0184819996, 0.0184819996, 0.0184819996) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.224285007, 0.224285007, 0.28125, 0.28125) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.001453, 0.001453, 0.001453, 0.001453) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(4.50000007e-05, 4.50000007e-05, 4.50000007e-05, 4.50000007e-05) + u_xlat16_0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.254662991, -0.254662991, -0.194030002, -0.194030002) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00571999978, 0.00571999978, 0.00571999978, 0.00571999978);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000302, 0.000302, 0.000302, 0.000302) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.133894995, -0.133894995, -0.074210003, -0.074210003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0490350015, 0.0490350015, 0.0490350015, 0.0490350015) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.191699997, 0.191699997, 0.191699997, 0.191699997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0148259997, -0.0148259997, 0.0444939993, 0.0444939993) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.343513995, 0.343513995, 0.343513995, 0.343513995) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.28283599, 0.28283599, 0.28283599, 0.28283599) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.104002997, 0.104002997, 0.163901001, 0.163901001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.106913, 0.106913, 0.106913, 0.106913) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0184819996, 0.0184819996, 0.0184819996, 0.0184819996) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.224285007, 0.224285007, 0.28125, 0.28125) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.001453, 0.001453, 0.001453, 0.001453) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(4.50000007e-05, 4.50000007e-05, 4.50000007e-05, 4.50000007e-05) + u_xlat16_0;
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
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 197901
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.954254985, -0.954254985, -0.830891013, -0.830891013) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000602999993, 0.000602999993, 0.000602999993, 0.000602999993);
    u_xlat16_0 = u_xlat10_0 * vec4(9.50000031e-05, 9.50000031e-05, 9.50000031e-05, 9.50000031e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.707616985, -0.707616985, -0.584424019, -0.584424019) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00297000003, 0.00297000003, 0.00297000003, 0.00297000003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0113390004, 0.0113390004, 0.0113390004, 0.0113390004) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.461302012, -0.461302012, -0.338239014, -0.338239014) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0335289985, 0.0335289985, 0.0335289985, 0.0335289985) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0768119991, 0.0768119991, 0.0768119991, 0.0768119991) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.215221003, -0.215221003, -0.0922319964, -0.0922319964) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.136344001, 0.136344001, 0.136344001, 0.136344001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.187530994, 0.187530994, 0.187530994, 0.187530994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0307439994, 0.0307439994, 0.153724, 0.153724) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.199875996, 0.199875996, 0.199875996, 0.199875996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.165081993, 0.165081993, 0.165081993, 0.165081993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.276726007, 0.276726007, 0.399764001, 0.399764001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.105653003, 0.105653003, 0.105653003, 0.105653003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0523930006, 0.0523930006, 0.0523930006, 0.0523930006) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.522854984, 0.522854984, 0.646010995, 0.646010995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0201299991, 0.0201299991, 0.0201299991, 0.0201299991) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00599199999, 0.00599199999, 0.00599199999, 0.00599199999) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.769243002, 0.769243002, 0.892561018, 0.892561018) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00138100004, 0.00138100004, 0.00138100004, 0.00138100004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000246999989, 0.000246999989, 0.000246999989, 0.000246999989) + u_xlat16_0;
    u_xlat1.xy = vs_TEXCOORD0.xy + _scaler.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(2.49999994e-05, 2.49999994e-05, 2.49999994e-05, 2.49999994e-05) + u_xlat16_0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.954254985, -0.954254985, -0.830891013, -0.830891013) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000602999993, 0.000602999993, 0.000602999993, 0.000602999993);
    u_xlat16_0 = u_xlat10_0 * vec4(9.50000031e-05, 9.50000031e-05, 9.50000031e-05, 9.50000031e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.707616985, -0.707616985, -0.584424019, -0.584424019) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00297000003, 0.00297000003, 0.00297000003, 0.00297000003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0113390004, 0.0113390004, 0.0113390004, 0.0113390004) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.461302012, -0.461302012, -0.338239014, -0.338239014) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0335289985, 0.0335289985, 0.0335289985, 0.0335289985) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0768119991, 0.0768119991, 0.0768119991, 0.0768119991) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.215221003, -0.215221003, -0.0922319964, -0.0922319964) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.136344001, 0.136344001, 0.136344001, 0.136344001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.187530994, 0.187530994, 0.187530994, 0.187530994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0307439994, 0.0307439994, 0.153724, 0.153724) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.199875996, 0.199875996, 0.199875996, 0.199875996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.165081993, 0.165081993, 0.165081993, 0.165081993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.276726007, 0.276726007, 0.399764001, 0.399764001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.105653003, 0.105653003, 0.105653003, 0.105653003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0523930006, 0.0523930006, 0.0523930006, 0.0523930006) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.522854984, 0.522854984, 0.646010995, 0.646010995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0201299991, 0.0201299991, 0.0201299991, 0.0201299991) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00599199999, 0.00599199999, 0.00599199999, 0.00599199999) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.769243002, 0.769243002, 0.892561018, 0.892561018) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00138100004, 0.00138100004, 0.00138100004, 0.00138100004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000246999989, 0.000246999989, 0.000246999989, 0.000246999989) + u_xlat16_0;
    u_xlat1.xy = vs_TEXCOORD0.xy + _scaler.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(2.49999994e-05, 2.49999994e-05, 2.49999994e-05, 2.49999994e-05) + u_xlat16_0;
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
in highp vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
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
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec2 _scaler;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
void main()
{
    u_xlat0 = _scaler.xyxy * vec4(-0.954254985, -0.954254985, -0.830891013, -0.830891013) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000602999993, 0.000602999993, 0.000602999993, 0.000602999993);
    u_xlat16_0 = u_xlat10_0 * vec4(9.50000031e-05, 9.50000031e-05, 9.50000031e-05, 9.50000031e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.707616985, -0.707616985, -0.584424019, -0.584424019) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00297000003, 0.00297000003, 0.00297000003, 0.00297000003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0113390004, 0.0113390004, 0.0113390004, 0.0113390004) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.461302012, -0.461302012, -0.338239014, -0.338239014) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0335289985, 0.0335289985, 0.0335289985, 0.0335289985) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0768119991, 0.0768119991, 0.0768119991, 0.0768119991) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.215221003, -0.215221003, -0.0922319964, -0.0922319964) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.136344001, 0.136344001, 0.136344001, 0.136344001) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.187530994, 0.187530994, 0.187530994, 0.187530994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0307439994, 0.0307439994, 0.153724, 0.153724) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.199875996, 0.199875996, 0.199875996, 0.199875996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.165081993, 0.165081993, 0.165081993, 0.165081993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.276726007, 0.276726007, 0.399764001, 0.399764001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.105653003, 0.105653003, 0.105653003, 0.105653003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0523930006, 0.0523930006, 0.0523930006, 0.0523930006) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.522854984, 0.522854984, 0.646010995, 0.646010995) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0201299991, 0.0201299991, 0.0201299991, 0.0201299991) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00599199999, 0.00599199999, 0.00599199999, 0.00599199999) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.769243002, 0.769243002, 0.892561018, 0.892561018) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00138100004, 0.00138100004, 0.00138100004, 0.00138100004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000246999989, 0.000246999989, 0.000246999989, 0.000246999989) + u_xlat16_0;
    u_xlat1.xy = vs_TEXCOORD0.xy + _scaler.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(2.49999994e-05, 2.49999994e-05, 2.49999994e-05, 2.49999994e-05) + u_xlat16_0;
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