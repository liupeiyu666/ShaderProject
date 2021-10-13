//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilterMQ" {
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
  GpuProgramID 43866
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
    u_xlat0 = _scaler.xyxy * vec4(-0.0119120004, -0.0119120004, -0.00476399995, -0.00476399995) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.308025986, 0.308025986, 0.308025986, 0.308025986);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00860899966, 0.00860899966, 0.00860899966, 0.00860899966) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.00154700002, 0.00154700002, 0.00823399983, 0.00823399983) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.607088029, 0.607088029, 0.607088029, 0.607088029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0758519992, 0.0758519992, 0.0758519992, 0.0758519992) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.015625, 0.015625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000425000006, 0.000425000006, 0.000425000006, 0.000425000006) + u_xlat16_0;
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
    u_xlat0 = _scaler.xyxy * vec4(-0.0119120004, -0.0119120004, -0.00476399995, -0.00476399995) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.308025986, 0.308025986, 0.308025986, 0.308025986);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00860899966, 0.00860899966, 0.00860899966, 0.00860899966) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.00154700002, 0.00154700002, 0.00823399983, 0.00823399983) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.607088029, 0.607088029, 0.607088029, 0.607088029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0758519992, 0.0758519992, 0.0758519992, 0.0758519992) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.015625, 0.015625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000425000006, 0.000425000006, 0.000425000006, 0.000425000006) + u_xlat16_0;
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
    u_xlat0 = _scaler.xyxy * vec4(-0.0119120004, -0.0119120004, -0.00476399995, -0.00476399995) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.308025986, 0.308025986, 0.308025986, 0.308025986);
    u_xlat16_0 = u_xlat10_0 * vec4(0.00860899966, 0.00860899966, 0.00860899966, 0.00860899966) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(0.00154700002, 0.00154700002, 0.00823399983, 0.00823399983) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.607088029, 0.607088029, 0.607088029, 0.607088029) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0758519992, 0.0758519992, 0.0758519992, 0.0758519992) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.015625, 0.015625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(0.000425000006, 0.000425000006, 0.000425000006, 0.000425000006) + u_xlat16_0;
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
  GpuProgramID 82644
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
    u_xlat0 = _scaler.xyxy * vec4(-0.0475560017, -0.0475560017, -0.0325350016, -0.0325350016) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0159489997, 0.0159489997, 0.0159489997, 0.0159489997);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0178779997, -0.0178779997, -0.00355400005, -0.00355400005) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.163608998, 0.163608998, 0.163608998, 0.163608998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.439938992, 0.439938992, 0.439938992, 0.439938992) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0106859999, 0.0106859999, 0.0251579992, 0.0251579992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.316579998, 0.316579998, 0.316579998, 0.316579998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0605119988, 0.0605119988, 0.0605119988, 0.0605119988) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0400049984, 0.0400049984, 0.0546879992, 0.0546879992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00298199989, 0.00298199989, 0.00298199989, 0.00298199989) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(3.40000006e-05, 3.40000006e-05, 3.40000006e-05, 3.40000006e-05) + u_xlat16_0;
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
    u_xlat0 = _scaler.xyxy * vec4(-0.0475560017, -0.0475560017, -0.0325350016, -0.0325350016) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0159489997, 0.0159489997, 0.0159489997, 0.0159489997);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0178779997, -0.0178779997, -0.00355400005, -0.00355400005) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.163608998, 0.163608998, 0.163608998, 0.163608998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.439938992, 0.439938992, 0.439938992, 0.439938992) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0106859999, 0.0106859999, 0.0251579992, 0.0251579992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.316579998, 0.316579998, 0.316579998, 0.316579998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0605119988, 0.0605119988, 0.0605119988, 0.0605119988) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0400049984, 0.0400049984, 0.0546879992, 0.0546879992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00298199989, 0.00298199989, 0.00298199989, 0.00298199989) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(3.40000006e-05, 3.40000006e-05, 3.40000006e-05, 3.40000006e-05) + u_xlat16_0;
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
    u_xlat0 = _scaler.xyxy * vec4(-0.0475560017, -0.0475560017, -0.0325350016, -0.0325350016) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.0159489997, 0.0159489997, 0.0159489997, 0.0159489997);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000394000002, 0.000394000002, 0.000394000002, 0.000394000002) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0178779997, -0.0178779997, -0.00355400005, -0.00355400005) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.163608998, 0.163608998, 0.163608998, 0.163608998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.439938992, 0.439938992, 0.439938992, 0.439938992) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0106859999, 0.0106859999, 0.0251579992, 0.0251579992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.316579998, 0.316579998, 0.316579998, 0.316579998) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0605119988, 0.0605119988, 0.0605119988, 0.0605119988) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0400049984, 0.0400049984, 0.0546879992, 0.0546879992) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00298199989, 0.00298199989, 0.00298199989, 0.00298199989) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(3.40000006e-05, 3.40000006e-05, 3.40000006e-05, 3.40000006e-05) + u_xlat16_0;
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
  GpuProgramID 133408
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
    u_xlat0 = _scaler.xyxy * vec4(-0.143375993, -0.143375993, -0.112940997, -0.112940997) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00389300007, 0.00389300007, 0.00389300007, 0.00389300007);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000270999997, 0.000270999997, 0.000270999997, 0.000270999997) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0826620013, -0.0826620013, -0.0525240004, -0.0525240004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0297420006, 0.0297420006, 0.0297420006, 0.0297420006) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.121250004, 0.121250004, 0.121250004, 0.121250004) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0224900004, -0.0224900004, 0.00749500003, 0.00749500003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.264445007, 0.264445007, 0.264445007, 0.264445007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.309049994, 0.309049994, 0.309049994, 0.309049994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.037498001, 0.037498001, 0.0675780028, 0.0675780028) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.193601996, 0.193601996, 0.193601996, 0.193601996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0649449974, 0.0649449974, 0.0649449974, 0.0649449974) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0977829993, 0.0977829993, 0.128139004, 0.128139004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0116410004, 0.0116410004, 0.0116410004, 0.0116410004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00111199997, 0.00111199997, 0.00111199997, 0.00111199997) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.15625, 0.15625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(4.80000017e-05, 4.80000017e-05, 4.80000017e-05, 4.80000017e-05) + u_xlat16_0;
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
    u_xlat0 = _scaler.xyxy * vec4(-0.143375993, -0.143375993, -0.112940997, -0.112940997) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00389300007, 0.00389300007, 0.00389300007, 0.00389300007);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000270999997, 0.000270999997, 0.000270999997, 0.000270999997) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0826620013, -0.0826620013, -0.0525240004, -0.0525240004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0297420006, 0.0297420006, 0.0297420006, 0.0297420006) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.121250004, 0.121250004, 0.121250004, 0.121250004) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0224900004, -0.0224900004, 0.00749500003, 0.00749500003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.264445007, 0.264445007, 0.264445007, 0.264445007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.309049994, 0.309049994, 0.309049994, 0.309049994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.037498001, 0.037498001, 0.0675780028, 0.0675780028) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.193601996, 0.193601996, 0.193601996, 0.193601996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0649449974, 0.0649449974, 0.0649449974, 0.0649449974) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0977829993, 0.0977829993, 0.128139004, 0.128139004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0116410004, 0.0116410004, 0.0116410004, 0.0116410004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00111199997, 0.00111199997, 0.00111199997, 0.00111199997) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.15625, 0.15625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(4.80000017e-05, 4.80000017e-05, 4.80000017e-05, 4.80000017e-05) + u_xlat16_0;
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
    u_xlat0 = _scaler.xyxy * vec4(-0.143375993, -0.143375993, -0.112940997, -0.112940997) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.00389300007, 0.00389300007, 0.00389300007, 0.00389300007);
    u_xlat16_0 = u_xlat10_0 * vec4(0.000270999997, 0.000270999997, 0.000270999997, 0.000270999997) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.0826620013, -0.0826620013, -0.0525240004, -0.0525240004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0297420006, 0.0297420006, 0.0297420006, 0.0297420006) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.121250004, 0.121250004, 0.121250004, 0.121250004) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0224900004, -0.0224900004, 0.00749500003, 0.00749500003) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.264445007, 0.264445007, 0.264445007, 0.264445007) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.309049994, 0.309049994, 0.309049994, 0.309049994) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.037498001, 0.037498001, 0.0675780028, 0.0675780028) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.193601996, 0.193601996, 0.193601996, 0.193601996) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0649449974, 0.0649449974, 0.0649449974, 0.0649449974) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0977829993, 0.0977829993, 0.128139004, 0.128139004) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0116410004, 0.0116410004, 0.0116410004, 0.0116410004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00111199997, 0.00111199997, 0.00111199997, 0.00111199997) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.15625, 0.15625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(4.80000017e-05, 4.80000017e-05, 4.80000017e-05, 4.80000017e-05) + u_xlat16_0;
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
  GpuProgramID 257965
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
    u_xlat0 = _scaler.xyxy * vec4(-0.539946973, -0.539946973, -0.478147, -0.478147) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000291000004, 0.000291000004, 0.000291000004, 0.000291000004);
    u_xlat16_0 = u_xlat10_0 * vec4(4.89999984e-05, 4.89999984e-05, 4.89999984e-05, 4.89999984e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.416377991, -0.416377991, -0.354636997, -0.354636997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00138300005, 0.00138300005, 0.00138300005, 0.00138300005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00529999984, 0.00529999984, 0.00529999984, 0.00529999984) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.29292199, -0.29292199, -0.231227994, -0.231227994) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0163780004, 0.0163780004, 0.0163780004, 0.0163780004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0408219993, 0.0408219993, 0.0408219993, 0.0408219993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.169552997, -0.169552997, -0.107891001, -0.107891001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0820680037, 0.0820680037, 0.0820680037, 0.0820680037) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.133082002, 0.133082002, 0.133082002, 0.133082002) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0462369993, -0.0462369993, 0.015412, 0.015412) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.174079999, 0.174079999, 0.174079999, 0.174079999) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.183685005, 0.183685005, 0.183685005, 0.183685005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0770630017, 0.0770630017, 0.138720006, 0.138720006) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.156350002, 0.156350002, 0.156350002, 0.156350002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.107352003, 0.107352003, 0.107352003, 0.107352003) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.200387999, 0.200387999, 0.262071997, 0.262071997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0594570003, 0.0594570003, 0.0594570003, 0.0594570003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0265619997, 0.0265619997, 0.0265619997, 0.0265619997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.323776007, 0.323776007, 0.385504007, 0.385504007) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.009571, 0.009571, 0.009571, 0.009571) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00278099999, 0.00278099999, 0.00278099999, 0.00278099999) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.447257996, 0.447257996, 0.509042978, 0.509042978) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.000652000017, 0.000652000017, 0.000652000017, 0.000652000017) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000123000005, 0.000123000005, 0.000123000005, 0.000123000005) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.5625, 0.5625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.40000002e-05, 1.40000002e-05, 1.40000002e-05, 1.40000002e-05) + u_xlat16_0;
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
    u_xlat0 = _scaler.xyxy * vec4(-0.539946973, -0.539946973, -0.478147, -0.478147) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000291000004, 0.000291000004, 0.000291000004, 0.000291000004);
    u_xlat16_0 = u_xlat10_0 * vec4(4.89999984e-05, 4.89999984e-05, 4.89999984e-05, 4.89999984e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.416377991, -0.416377991, -0.354636997, -0.354636997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00138300005, 0.00138300005, 0.00138300005, 0.00138300005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00529999984, 0.00529999984, 0.00529999984, 0.00529999984) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.29292199, -0.29292199, -0.231227994, -0.231227994) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0163780004, 0.0163780004, 0.0163780004, 0.0163780004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0408219993, 0.0408219993, 0.0408219993, 0.0408219993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.169552997, -0.169552997, -0.107891001, -0.107891001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0820680037, 0.0820680037, 0.0820680037, 0.0820680037) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.133082002, 0.133082002, 0.133082002, 0.133082002) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0462369993, -0.0462369993, 0.015412, 0.015412) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.174079999, 0.174079999, 0.174079999, 0.174079999) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.183685005, 0.183685005, 0.183685005, 0.183685005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0770630017, 0.0770630017, 0.138720006, 0.138720006) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.156350002, 0.156350002, 0.156350002, 0.156350002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.107352003, 0.107352003, 0.107352003, 0.107352003) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.200387999, 0.200387999, 0.262071997, 0.262071997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0594570003, 0.0594570003, 0.0594570003, 0.0594570003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0265619997, 0.0265619997, 0.0265619997, 0.0265619997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.323776007, 0.323776007, 0.385504007, 0.385504007) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.009571, 0.009571, 0.009571, 0.009571) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00278099999, 0.00278099999, 0.00278099999, 0.00278099999) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.447257996, 0.447257996, 0.509042978, 0.509042978) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.000652000017, 0.000652000017, 0.000652000017, 0.000652000017) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000123000005, 0.000123000005, 0.000123000005, 0.000123000005) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.5625, 0.5625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.40000002e-05, 1.40000002e-05, 1.40000002e-05, 1.40000002e-05) + u_xlat16_0;
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
    u_xlat0 = _scaler.xyxy * vec4(-0.539946973, -0.539946973, -0.478147, -0.478147) + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * vec4(0.000291000004, 0.000291000004, 0.000291000004, 0.000291000004);
    u_xlat16_0 = u_xlat10_0 * vec4(4.89999984e-05, 4.89999984e-05, 4.89999984e-05, 4.89999984e-05) + u_xlat16_1;
    u_xlat1 = _scaler.xyxy * vec4(-0.416377991, -0.416377991, -0.354636997, -0.354636997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.00138300005, 0.00138300005, 0.00138300005, 0.00138300005) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00529999984, 0.00529999984, 0.00529999984, 0.00529999984) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.29292199, -0.29292199, -0.231227994, -0.231227994) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0163780004, 0.0163780004, 0.0163780004, 0.0163780004) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0408219993, 0.0408219993, 0.0408219993, 0.0408219993) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.169552997, -0.169552997, -0.107891001, -0.107891001) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0820680037, 0.0820680037, 0.0820680037, 0.0820680037) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.133082002, 0.133082002, 0.133082002, 0.133082002) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(-0.0462369993, -0.0462369993, 0.015412, 0.015412) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.174079999, 0.174079999, 0.174079999, 0.174079999) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.183685005, 0.183685005, 0.183685005, 0.183685005) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.0770630017, 0.0770630017, 0.138720006, 0.138720006) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.156350002, 0.156350002, 0.156350002, 0.156350002) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.107352003, 0.107352003, 0.107352003, 0.107352003) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.200387999, 0.200387999, 0.262071997, 0.262071997) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.0594570003, 0.0594570003, 0.0594570003, 0.0594570003) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.0265619997, 0.0265619997, 0.0265619997, 0.0265619997) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.323776007, 0.323776007, 0.385504007, 0.385504007) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.009571, 0.009571, 0.009571, 0.009571) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.00278099999, 0.00278099999, 0.00278099999, 0.00278099999) + u_xlat16_0;
    u_xlat1 = _scaler.xyxy * vec4(0.447257996, 0.447257996, 0.509042978, 0.509042978) + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * vec4(0.000652000017, 0.000652000017, 0.000652000017, 0.000652000017) + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * vec4(0.000123000005, 0.000123000005, 0.000123000005, 0.000123000005) + u_xlat16_0;
    u_xlat1.xy = _scaler.xy * vec2(0.5625, 0.5625) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat16_0 = u_xlat10_1 * vec4(1.40000002e-05, 1.40000002e-05, 1.40000002e-05, 1.40000002e-05) + u_xlat16_0;
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