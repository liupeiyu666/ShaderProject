//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/RainDistortion" {
Properties {
_Strength ("Distortion Strength", Range(0, 1000)) = 50
_Distortion ("Normalmap", 2D) = "bump" { }
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Always
  GpuProgramID 1204
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _CameraTex_TexelSize;
uniform 	mediump float _Strength;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD1;
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
    vs_TEXCOORD2.xy = _CameraTex_TexelSize.xy * vec2(_Strength);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _CameraTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlat10_0.xy = texture(_Distortion, vs_TEXCOORD0.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = (-vs_TEXCOORD2.xy) * u_xlat16_1.xy + vs_TEXCOORD1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture(_CameraTex, u_xlat16_1.xy);
    SV_Target0 = u_xlat10_0;
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
uniform 	mediump vec4 _CameraTex_TexelSize;
uniform 	mediump float _Strength;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD1;
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
    vs_TEXCOORD2.xy = _CameraTex_TexelSize.xy * vec2(_Strength);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _CameraTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlat10_0.xy = texture(_Distortion, vs_TEXCOORD0.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = (-vs_TEXCOORD2.xy) * u_xlat16_1.xy + vs_TEXCOORD1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture(_CameraTex, u_xlat16_1.xy);
    SV_Target0 = u_xlat10_0;
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
uniform 	mediump vec4 _CameraTex_TexelSize;
uniform 	mediump float _Strength;
in mediump vec4 in_POSITION0;
in mediump vec2 in_TEXCOORD0;
out mediump vec2 vs_TEXCOORD0;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD1;
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
    vs_TEXCOORD2.xy = _CameraTex_TexelSize.xy * vec2(_Strength);
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD1 = u_xlat0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _Distortion;
uniform lowp sampler2D _CameraTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
mediump vec2 u_xlat16_1;
void main()
{
    u_xlat10_0.xy = texture(_Distortion, vs_TEXCOORD0.xy).xy;
    u_xlat16_1.xy = u_xlat10_0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
    u_xlat16_1.xy = (-vs_TEXCOORD2.xy) * u_xlat16_1.xy + vs_TEXCOORD1.xy;
    u_xlat16_1.xy = u_xlat16_1.xy / vs_TEXCOORD1.ww;
    u_xlat10_0 = texture(_CameraTex, u_xlat16_1.xy);
    SV_Target0 = u_xlat10_0;
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