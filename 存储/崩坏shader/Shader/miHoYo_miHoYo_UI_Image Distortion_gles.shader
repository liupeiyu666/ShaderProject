//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Distortion" {
Properties {
_MainTex ("mianTexture", 2D) = "white" { }
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseIntensity ("NoiseIntensity", Vector) = (0,0,0,0)
_NoiseSpeed ("NoiseSpeed", Vector) = (0,0,0,0)
_NoiseTilling ("NoiseTilling", Vector) = (1,1,0,0)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  GpuProgramID 102
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec2 _NoiseTilling;
uniform highp vec2 _NoiseIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _NoiseSpeed) + (xlv_TEXCOORD0.xy * _NoiseTilling));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_NoiseTex, tmpvar_4);
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = _NoiseIntensity;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (tmpvar_5 + (tmpvar_6 * tmpvar_7)).xy;
  tmpvar_8 = texture2D (_MainTex, P_9);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = tex2DNode1_3.w;
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = tex2DNode1_3.xyz;
  aseOutColor_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec2 _NoiseTilling;
uniform highp vec2 _NoiseIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _NoiseSpeed) + (xlv_TEXCOORD0.xy * _NoiseTilling));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_NoiseTex, tmpvar_4);
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = _NoiseIntensity;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (tmpvar_5 + (tmpvar_6 * tmpvar_7)).xy;
  tmpvar_8 = texture2D (_MainTex, P_9);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = tex2DNode1_3.w;
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = tex2DNode1_3.xyz;
  aseOutColor_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec2 _NoiseTilling;
uniform highp vec2 _NoiseIntensity;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _NoiseSpeed) + (xlv_TEXCOORD0.xy * _NoiseTilling));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_NoiseTex, tmpvar_4);
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = _NoiseIntensity;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (tmpvar_5 + (tmpvar_6 * tmpvar_7)).xy;
  tmpvar_8 = texture2D (_MainTex, P_9);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = tex2DNode1_3.w;
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = tex2DNode1_3.xyz;
  aseOutColor_1 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}