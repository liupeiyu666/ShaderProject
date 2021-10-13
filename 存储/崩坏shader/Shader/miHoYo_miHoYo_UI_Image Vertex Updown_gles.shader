//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Vertex Updown" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_Frequency ("Frequency", Float) = 1
_FrequencyMove ("FrequencyMove", Float) = 1
_Magnitude ("Magnitude", Float) = 1
_AlphaColor ("AlphaColorScale", Float) = 1
_AlphaColorPow ("AlphaColorPow", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 19644
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Frequency;
uniform mediump float _FrequencyMove;
uniform mediump float _Magnitude;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 worldPosVer_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
  worldPosVer_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (sin((
    (_Time.y * _Frequency)
   + 
    (worldPosVer_1.x * _FrequencyMove)
  )) * _Magnitude);
  worldPosVer_1.y = (worldPosVer_1.y + tmpvar_3);
  gl_Position = (unity_MatrixVP * worldPosVer_1);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_WorldToObject * worldPosVer_1);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _AlphaColor;
uniform mediump float _AlphaColorPow;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = ((2.0 * _TintColor).xyz * _EmissionScaler);
  highp float tmpvar_2;
  tmpvar_2 = clamp (((xlv_TEXCOORD2.y + _AlphaColor) * _AlphaColorPow), 0.0, 1.0);
  color_1.w = (tmpvar_2 * _TintColor.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Frequency;
uniform mediump float _FrequencyMove;
uniform mediump float _Magnitude;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 worldPosVer_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
  worldPosVer_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (sin((
    (_Time.y * _Frequency)
   + 
    (worldPosVer_1.x * _FrequencyMove)
  )) * _Magnitude);
  worldPosVer_1.y = (worldPosVer_1.y + tmpvar_3);
  gl_Position = (unity_MatrixVP * worldPosVer_1);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_WorldToObject * worldPosVer_1);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _AlphaColor;
uniform mediump float _AlphaColorPow;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = ((2.0 * _TintColor).xyz * _EmissionScaler);
  highp float tmpvar_2;
  tmpvar_2 = clamp (((xlv_TEXCOORD2.y + _AlphaColor) * _AlphaColorPow), 0.0, 1.0);
  color_1.w = (tmpvar_2 * _TintColor.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _Frequency;
uniform mediump float _FrequencyMove;
uniform mediump float _Magnitude;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 worldPosVer_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_ObjectToWorld * _glesVertex);
  worldPosVer_1 = tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (sin((
    (_Time.y * _Frequency)
   + 
    (worldPosVer_1.x * _FrequencyMove)
  )) * _Magnitude);
  worldPosVer_1.y = (worldPosVer_1.y + tmpvar_3);
  gl_Position = (unity_MatrixVP * worldPosVer_1);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (unity_WorldToObject * worldPosVer_1);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _AlphaColor;
uniform mediump float _AlphaColorPow;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = ((2.0 * _TintColor).xyz * _EmissionScaler);
  highp float tmpvar_2;
  tmpvar_2 = clamp (((xlv_TEXCOORD2.y + _AlphaColor) * _AlphaColorPow), 0.0, 1.0);
  color_1.w = (tmpvar_2 * _TintColor.w);
  gl_FragData[0] = color_1;
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}