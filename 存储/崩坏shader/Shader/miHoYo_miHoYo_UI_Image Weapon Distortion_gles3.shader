//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Weapon Distortion" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
_ColorMask ("Color Mask", Float) = 15
_DistortionTex ("Distortion Tex (RG)", 2D) = "gray" { }
_DistortionFrequency ("Distortion Frequency", Float) = 1
_DistortionAmplitude ("Distortion Amplitude", Range(0, 1)) = 1
_DistortionAnmSpeed ("Distortion Animation Speed", Float) = 1
_NoiseTex ("Noise Tex (RGB)", 2D) = "black" { }
_NoiseAnmSpeed ("Noise Animation Speed", Float) = 1
_NoiseStrength ("Noise Strength", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstFactor ("DstFactor", Float) = 10
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 23587
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _DistortionFrequency;
uniform 	mediump float _DistortionAnmSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseAnmSpeed;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.z = _Time.y * _DistortionAnmSpeed;
    u_xlat0.w = in_TEXCOORD0.y * _DistortionFrequency;
    u_xlat0.xy = in_TEXCOORD0.xy;
    phase0_Output0_2 = u_xlat0;
    u_xlat0.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat4.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat0.zw = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat0 = fract(u_xlat0);
    u_xlat0.xy = vec2(u_xlat0.z + u_xlat0.x, u_xlat0.w + u_xlat0.y);
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(_NoiseAnmSpeed) + u_xlat4.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DistortionAmplitude;
uniform 	mediump float _NoiseStrength;
uniform 	mediump vec4 _Color;
uniform 	float _ColorScaler;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_NoiseStrength);
    u_xlat10_12 = texture(_DistortionTex, vs_TEXCOORD1.xy).x;
    u_xlat16_12 = u_xlat10_12 + -0.497999996;
    u_xlat16_1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionAmplitude, _DistortionAmplitude)) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * vec4(_ColorScaler);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * u_xlat1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.www + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat1.w;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _DistortionFrequency;
uniform 	mediump float _DistortionAnmSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseAnmSpeed;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.z = _Time.y * _DistortionAnmSpeed;
    u_xlat0.w = in_TEXCOORD0.y * _DistortionFrequency;
    u_xlat0.xy = in_TEXCOORD0.xy;
    phase0_Output0_2 = u_xlat0;
    u_xlat0.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat4.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat0.zw = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat0 = fract(u_xlat0);
    u_xlat0.xy = vec2(u_xlat0.z + u_xlat0.x, u_xlat0.w + u_xlat0.y);
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(_NoiseAnmSpeed) + u_xlat4.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DistortionAmplitude;
uniform 	mediump float _NoiseStrength;
uniform 	mediump vec4 _Color;
uniform 	float _ColorScaler;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_NoiseStrength);
    u_xlat10_12 = texture(_DistortionTex, vs_TEXCOORD1.xy).x;
    u_xlat16_12 = u_xlat10_12 + -0.497999996;
    u_xlat16_1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionAmplitude, _DistortionAmplitude)) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * vec4(_ColorScaler);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * u_xlat1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.www + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat1.w;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _DistortionFrequency;
uniform 	mediump float _DistortionAnmSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseAnmSpeed;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.z = _Time.y * _DistortionAnmSpeed;
    u_xlat0.w = in_TEXCOORD0.y * _DistortionFrequency;
    u_xlat0.xy = in_TEXCOORD0.xy;
    phase0_Output0_2 = u_xlat0;
    u_xlat0.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat0.xy = sin(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy * vec2(43758.5469, 43758.5469);
    u_xlat4.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat4.xy = sin(u_xlat4.xy);
    u_xlat0.zw = u_xlat4.xy * vec2(43758.5469, 43758.5469);
    u_xlat0 = fract(u_xlat0);
    u_xlat0.xy = vec2(u_xlat0.z + u_xlat0.x, u_xlat0.w + u_xlat0.y);
    u_xlat4.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat0.xy = u_xlat0.xy * vec2(_NoiseAnmSpeed) + u_xlat4.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump float _DistortionAmplitude;
uniform 	mediump float _NoiseStrength;
uniform 	mediump vec4 _Color;
uniform 	float _ColorScaler;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
vec4 u_xlat1;
mediump vec2 u_xlat16_1;
lowp vec4 u_xlat10_1;
mediump vec3 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump float u_xlat16_12;
lowp float u_xlat10_12;
void main()
{
    u_xlat10_0.xyz = texture(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_0.xyz = u_xlat10_0.xyz * vec3(_NoiseStrength);
    u_xlat10_12 = texture(_DistortionTex, vs_TEXCOORD1.xy).x;
    u_xlat16_12 = u_xlat10_12 + -0.497999996;
    u_xlat16_1.xy = vec2(u_xlat16_12) * vec2(vec2(_DistortionAmplitude, _DistortionAmplitude)) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture(_MainTex, u_xlat16_1.xy);
    u_xlat1 = u_xlat10_1 * vec4(_ColorScaler);
    u_xlat16_2.xyz = (-u_xlat16_0.xyz) * u_xlat1.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = (-u_xlat1.xyz) * vs_COLOR0.www + vec3(1.0, 1.0, 1.0);
    SV_Target0.w = u_xlat1.w;
    u_xlat16_2.xyz = (-u_xlat16_3.xyz) * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
    SV_Target0.xyz = u_xlat16_2.xyz * _Color.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _DistortionFrequency;
uniform 	mediump float _DistortionAnmSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseAnmSpeed;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
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
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat1.z = _Time.y * _DistortionAnmSpeed;
    u_xlat1.w = in_TEXCOORD0.y * _DistortionFrequency;
    u_xlat1.xy = in_TEXCOORD0.xy;
    phase0_Output0_2 = u_xlat1;
    u_xlat1.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat5.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat5.xy = sin(u_xlat5.xy);
    u_xlat1.zw = u_xlat5.xy * vec2(43758.5469, 43758.5469);
    u_xlat1 = fract(u_xlat1);
    u_xlat1.xy = vec2(u_xlat1.z + u_xlat1.x, u_xlat1.w + u_xlat1.y);
    u_xlat5.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(_NoiseAnmSpeed) + u_xlat5.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _DistortionAmplitude;
uniform 	mediump float _NoiseStrength;
uniform 	mediump vec4 _Color;
uniform 	float _ColorScaler;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
bool u_xlatb17;
void main()
{
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_0.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.z * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.w * u_xlat16_0.x;
    u_xlat10_2.xyz = texture(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(_NoiseStrength);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat16_0.x * _DistortionAmplitude;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.0<u_xlat16_0.x);
#else
    u_xlatb17 = 0.0<u_xlat16_0.x;
#endif
    u_xlat10_3 = texture(_DistortionTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = u_xlat10_3 + -0.497999996;
    u_xlat16_0.xy = vec2(u_xlat16_3) * vec2(u_xlat16_5) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * vec4(_ColorScaler);
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) * u_xlat0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = (bool(u_xlatb17)) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _DistortionFrequency;
uniform 	mediump float _DistortionAnmSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseAnmSpeed;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
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
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat1.z = _Time.y * _DistortionAnmSpeed;
    u_xlat1.w = in_TEXCOORD0.y * _DistortionFrequency;
    u_xlat1.xy = in_TEXCOORD0.xy;
    phase0_Output0_2 = u_xlat1;
    u_xlat1.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat5.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat5.xy = sin(u_xlat5.xy);
    u_xlat1.zw = u_xlat5.xy * vec2(43758.5469, 43758.5469);
    u_xlat1 = fract(u_xlat1);
    u_xlat1.xy = vec2(u_xlat1.z + u_xlat1.x, u_xlat1.w + u_xlat1.y);
    u_xlat5.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(_NoiseAnmSpeed) + u_xlat5.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _DistortionAmplitude;
uniform 	mediump float _NoiseStrength;
uniform 	mediump vec4 _Color;
uniform 	float _ColorScaler;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
bool u_xlatb17;
void main()
{
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_0.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.z * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.w * u_xlat16_0.x;
    u_xlat10_2.xyz = texture(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(_NoiseStrength);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat16_0.x * _DistortionAmplitude;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.0<u_xlat16_0.x);
#else
    u_xlatb17 = 0.0<u_xlat16_0.x;
#endif
    u_xlat10_3 = texture(_DistortionTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = u_xlat10_3 + -0.497999996;
    u_xlat16_0.xy = vec2(u_xlat16_3) * vec2(u_xlat16_5) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * vec4(_ColorScaler);
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) * u_xlat0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = (bool(u_xlatb17)) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _SinTime;
uniform 	vec4 _CosTime;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump float _DistortionFrequency;
uniform 	mediump float _DistortionAnmSpeed;
uniform 	vec4 _NoiseTex_ST;
uniform 	float _NoiseAnmSpeed;
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out mediump vec2 vs_TEXCOORD2;
out mediump vec4 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
vec2 u_xlat5;
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
    u_xlat1 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat1;
    u_xlat1.z = _Time.y * _DistortionAnmSpeed;
    u_xlat1.w = in_TEXCOORD0.y * _DistortionFrequency;
    u_xlat1.xy = in_TEXCOORD0.xy;
    phase0_Output0_2 = u_xlat1;
    u_xlat1.xy = _SinTime.wx * vec2(12.9898005, 12.9898005);
    u_xlat1.xy = sin(u_xlat1.xy);
    u_xlat1.xy = u_xlat1.xy * vec2(43758.5469, 43758.5469);
    u_xlat5.xy = _CosTime.xw * vec2(12.9898005, 12.9898005);
    u_xlat5.xy = sin(u_xlat5.xy);
    u_xlat1.zw = u_xlat5.xy * vec2(43758.5469, 43758.5469);
    u_xlat1 = fract(u_xlat1);
    u_xlat1.xy = vec2(u_xlat1.z + u_xlat1.x, u_xlat1.w + u_xlat1.y);
    u_xlat5.xy = in_TEXCOORD0.xy * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
    u_xlat1.xy = u_xlat1.xy * vec2(_NoiseAnmSpeed) + u_xlat5.xy;
    vs_TEXCOORD2.xy = u_xlat1.xy;
    u_xlat1.x = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.w = u_xlat1.x * 0.5;
    u_xlat1.xz = u_xlat0.xw * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
    vs_TEXCOORD4 = u_xlat0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _RMRect;
uniform 	mediump vec4 _RMTransitWidth;
uniform 	mediump float _DistortionAmplitude;
uniform 	mediump float _NoiseStrength;
uniform 	mediump vec4 _Color;
uniform 	float _ColorScaler;
uniform lowp sampler2D _DistortionTex;
uniform lowp sampler2D _NoiseTex;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in mediump vec2 vs_TEXCOORD2;
in mediump vec4 vs_TEXCOORD4;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump vec4 u_xlat16_1;
mediump vec3 u_xlat16_2;
lowp vec3 u_xlat10_2;
mediump float u_xlat16_3;
lowp float u_xlat10_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_5;
bool u_xlatb17;
void main()
{
    u_xlat16_0 = vs_TEXCOORD4.xyxy / vs_TEXCOORD4.wwww;
    u_xlat16_0 = u_xlat16_0 + (-_RMRect);
    u_xlat16_0 = u_xlat16_0 * vec4(1.0, 1.0, -1.0, -1.0);
    u_xlat16_1 = max(_RMTransitWidth, vec4(9.99999975e-05, 9.99999975e-05, 9.99999975e-05, 9.99999975e-05));
    u_xlat16_1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat16_1;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
#else
    u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat16_0 * vec4(-2.0, -2.0, -2.0, -2.0) + vec4(3.0, 3.0, 3.0, 3.0);
    u_xlat16_0 = u_xlat16_0 * u_xlat16_0;
    u_xlat16_0 = u_xlat16_0 * u_xlat16_1;
    u_xlat16_0.x = u_xlat16_0.y * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.z * u_xlat16_0.x;
    u_xlat16_0.x = u_xlat16_0.w * u_xlat16_0.x;
    u_xlat10_2.xyz = texture(_NoiseTex, vs_TEXCOORD2.xy).xyz;
    u_xlat16_2.xyz = u_xlat10_2.xyz * vec3(_NoiseStrength);
    u_xlat16_2.xyz = u_xlat16_0.xxx * u_xlat16_2.xyz;
    u_xlat16_5 = u_xlat16_0.x * _DistortionAmplitude;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(0.0<u_xlat16_0.x);
#else
    u_xlatb17 = 0.0<u_xlat16_0.x;
#endif
    u_xlat10_3 = texture(_DistortionTex, vs_TEXCOORD1.xy).x;
    u_xlat16_3 = u_xlat10_3 + -0.497999996;
    u_xlat16_0.xy = vec2(u_xlat16_3) * vec2(u_xlat16_5) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture(_MainTex, u_xlat16_0.xy);
    u_xlat0 = u_xlat10_0 * vec4(_ColorScaler);
    u_xlat16_1.xyz = (-u_xlat16_2.xyz) * u_xlat0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = (-u_xlat0.xyz) * vs_COLOR0.www + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = (-u_xlat16_4.xyz) * u_xlat16_1.xyz + vec3(1.0, 1.0, 1.0);
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat16_4.xyz = u_xlat0.xyz * vs_COLOR0.www;
    SV_Target0.w = u_xlat0.w;
    SV_Target0.xyz = (bool(u_xlatb17)) ? u_xlat16_1.xyz : u_xlat16_4.xyz;
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
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "RECT_MASK" }
""
}
}
}
}
}