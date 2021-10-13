//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/BlurReflected" {
Properties {
_MainTex ("Base (RGB)", 2D) = "" { }
_offset_4_1 ("", Vector) = (0,0,0,0)
_offset_4_2 ("", Vector) = (0,0,0,0)
_weights ("", Vector) = (0,0,0,0)
_offset_4_3 ("", Vector) = (0,0,0,0)
_offset_4_4 ("", Vector) = (0,0,0,0)
_weights2 ("", Vector) = (0,0,0,0)
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 47796
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
uniform 	mediump vec4 _offset_4_1;
uniform 	mediump vec4 _offset_4_2;
uniform 	mediump vec4 _weights;
uniform 	mediump vec4 _offset_4_3;
uniform 	mediump vec4 _offset_4_4;
uniform 	mediump vec4 _weights2;
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
    u_xlat0 = _offset_4_1 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * _weights.yyyy;
    u_xlat16_0 = u_xlat10_0 * _weights.xxxx + u_xlat16_1;
    u_xlat1 = _offset_4_2 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights.zzzz + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights.wwww + u_xlat16_0;
    u_xlat1 = _offset_4_3 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights2.xxxx + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights2.yyyy + u_xlat16_0;
    u_xlat1 = _offset_4_4 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights2.zzzz + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights2.wwww + u_xlat16_0;
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
uniform 	mediump vec4 _offset_4_1;
uniform 	mediump vec4 _offset_4_2;
uniform 	mediump vec4 _weights;
uniform 	mediump vec4 _offset_4_3;
uniform 	mediump vec4 _offset_4_4;
uniform 	mediump vec4 _weights2;
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
    u_xlat0 = _offset_4_1 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * _weights.yyyy;
    u_xlat16_0 = u_xlat10_0 * _weights.xxxx + u_xlat16_1;
    u_xlat1 = _offset_4_2 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights.zzzz + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights.wwww + u_xlat16_0;
    u_xlat1 = _offset_4_3 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights2.xxxx + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights2.yyyy + u_xlat16_0;
    u_xlat1 = _offset_4_4 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights2.zzzz + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights2.wwww + u_xlat16_0;
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
uniform 	mediump vec4 _offset_4_1;
uniform 	mediump vec4 _offset_4_2;
uniform 	mediump vec4 _weights;
uniform 	mediump vec4 _offset_4_3;
uniform 	mediump vec4 _offset_4_4;
uniform 	mediump vec4 _weights2;
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
    u_xlat0 = _offset_4_1 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_1 = texture(_MainTex, u_xlat0.zw);
    u_xlat10_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat16_1 = u_xlat10_1 * _weights.yyyy;
    u_xlat16_0 = u_xlat10_0 * _weights.xxxx + u_xlat16_1;
    u_xlat1 = _offset_4_2 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights.zzzz + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights.wwww + u_xlat16_0;
    u_xlat1 = _offset_4_3 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights2.xxxx + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights2.yyyy + u_xlat16_0;
    u_xlat1 = _offset_4_4 * _scaler.xyxy + vs_TEXCOORD0.xyxy;
    u_xlat10_2 = texture(_MainTex, u_xlat1.xy);
    u_xlat10_1 = texture(_MainTex, u_xlat1.zw);
    u_xlat16_0 = u_xlat10_2 * _weights2.zzzz + u_xlat16_0;
    u_xlat16_0 = u_xlat10_1 * _weights2.wwww + u_xlat16_0;
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