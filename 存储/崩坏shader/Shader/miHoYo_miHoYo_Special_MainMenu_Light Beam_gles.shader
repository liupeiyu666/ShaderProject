//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Light Beam" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_LongitudinalIntensityTex ("Longitudinal Intensity Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_WidthRatio ("Width Ratio", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 35012
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _LongitudinalIntensityTex;
uniform mediump float _EmissionScaler;
uniform highp float _WidthRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump float i2_1;
  mediump float i1_2;
  mediump vec4 color_3;
  highp float u_4;
  highp float tmpvar_5;
  tmpvar_5 = mix (1.0, _WidthRatio, xlv_TEXCOORD0.y);
  u_4 = (((xlv_TEXCOORD0.x - 0.5) + (tmpvar_5 * 0.5)) / tmpvar_5);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_3.w = tmpvar_6.w;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, vec2(u_4)).x;
  i1_2 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_LongitudinalIntensityTex, xlv_TEXCOORD0.yy).x;
  i2_1 = tmpvar_8;
  color_3.xyz = (tmpvar_6.xyz * ((_EmissionScaler * i1_2) * i2_1));
  gl_FragData[0] = color_3;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _LongitudinalIntensityTex;
uniform mediump float _EmissionScaler;
uniform highp float _WidthRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump float i2_1;
  mediump float i1_2;
  mediump vec4 color_3;
  highp float u_4;
  highp float tmpvar_5;
  tmpvar_5 = mix (1.0, _WidthRatio, xlv_TEXCOORD0.y);
  u_4 = (((xlv_TEXCOORD0.x - 0.5) + (tmpvar_5 * 0.5)) / tmpvar_5);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_3.w = tmpvar_6.w;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, vec2(u_4)).x;
  i1_2 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_LongitudinalIntensityTex, xlv_TEXCOORD0.yy).x;
  i2_1 = tmpvar_8;
  color_3.xyz = (tmpvar_6.xyz * ((_EmissionScaler * i1_2) * i2_1));
  gl_FragData[0] = color_3;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _LongitudinalIntensityTex;
uniform mediump float _EmissionScaler;
uniform highp float _WidthRatio;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump float i2_1;
  mediump float i1_2;
  mediump vec4 color_3;
  highp float u_4;
  highp float tmpvar_5;
  tmpvar_5 = mix (1.0, _WidthRatio, xlv_TEXCOORD0.y);
  u_4 = (((xlv_TEXCOORD0.x - 0.5) + (tmpvar_5 * 0.5)) / tmpvar_5);
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * xlv_COLOR);
  color_3.w = tmpvar_6.w;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, vec2(u_4)).x;
  i1_2 = tmpvar_7;
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_LongitudinalIntensityTex, xlv_TEXCOORD0.yy).x;
  i2_1 = tmpvar_8;
  color_3.xyz = (tmpvar_6.xyz * ((_EmissionScaler * i1_2) * i2_1));
  gl_FragData[0] = color_3;
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
 Pass {
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 115133
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _LongitudinalIntensityTex;
uniform mediump float _BloomFactor;
uniform highp float _WidthRatio;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float i2_1;
  mediump float i1_2;
  highp float u_3;
  mediump vec4 color_4;
  color_4.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_5;
  tmpvar_5 = mix (1.0, _WidthRatio, xlv_TEXCOORD0.y);
  u_3 = (((xlv_TEXCOORD0.x - 0.5) + (tmpvar_5 * 0.5)) / tmpvar_5);
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, vec2(u_3)).x;
  i1_2 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_LongitudinalIntensityTex, xlv_TEXCOORD0.yy).x;
  i2_1 = tmpvar_7;
  color_4.w = ((_BloomFactor * i1_2) * i2_1);
  gl_FragData[0] = color_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _LongitudinalIntensityTex;
uniform mediump float _BloomFactor;
uniform highp float _WidthRatio;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float i2_1;
  mediump float i1_2;
  highp float u_3;
  mediump vec4 color_4;
  color_4.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_5;
  tmpvar_5 = mix (1.0, _WidthRatio, xlv_TEXCOORD0.y);
  u_3 = (((xlv_TEXCOORD0.x - 0.5) + (tmpvar_5 * 0.5)) / tmpvar_5);
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, vec2(u_3)).x;
  i1_2 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_LongitudinalIntensityTex, xlv_TEXCOORD0.yy).x;
  i2_1 = tmpvar_7;
  color_4.w = ((_BloomFactor * i1_2) * i2_1);
  gl_FragData[0] = color_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _LongitudinalIntensityTex;
uniform mediump float _BloomFactor;
uniform highp float _WidthRatio;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float i2_1;
  mediump float i1_2;
  highp float u_3;
  mediump vec4 color_4;
  color_4.xyz = vec3(0.0, 0.0, 0.0);
  highp float tmpvar_5;
  tmpvar_5 = mix (1.0, _WidthRatio, xlv_TEXCOORD0.y);
  u_3 = (((xlv_TEXCOORD0.x - 0.5) + (tmpvar_5 * 0.5)) / tmpvar_5);
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, vec2(u_3)).x;
  i1_2 = tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_LongitudinalIntensityTex, xlv_TEXCOORD0.yy).x;
  i2_1 = tmpvar_7;
  color_4.w = ((_BloomFactor * i1_2) * i2_1);
  gl_FragData[0] = color_4;
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
}