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
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.015931, -0.015931) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.036315);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.002697, -0.002697) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.689368));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.008811, 0.008811) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.272895));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.023438, 0.023438) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.001422));
  gl_FragData[0] = sum_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.015931, -0.015931) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.036315);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.002697, -0.002697) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.689368));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.008811, 0.008811) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.272895));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.023438, 0.023438) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.001422));
  gl_FragData[0] = sum_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.015931, -0.015931) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.036315);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.002697, -0.002697) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.689368));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.008811, 0.008811) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.272895));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.023438, 0.023438) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.001422));
  gl_FragData[0] = sum_2;
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
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 125232
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.079645, -0.079645) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.00178);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.049923, -0.049923) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.050978));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.021135, -0.021135) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.320296));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007024, 0.007024) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.461242));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.035414, 0.035414) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.15398));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.064674, 0.064674) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.01155));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.09375, 0.09375) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.000173));
  gl_FragData[0] = sum_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.079645, -0.079645) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.00178);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.049923, -0.049923) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.050978));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.021135, -0.021135) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.320296));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007024, 0.007024) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.461242));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.035414, 0.035414) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.15398));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.064674, 0.064674) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.01155));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.09375, 0.09375) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.000173));
  gl_FragData[0] = sum_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.079645, -0.079645) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.00178);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.049923, -0.049923) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.050978));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.021135, -0.021135) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.320296));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007024, 0.007024) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.461242));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.035414, 0.035414) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.15398));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.064674, 0.064674) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.01155));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.09375, 0.09375) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.000173));
  gl_FragData[0] = sum_2;
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
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 155074
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.254663, -0.254663) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000302);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.19403, -0.19403) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.00572));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.133895, -0.133895) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.049035));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.07421, -0.07421) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.1917));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.014826, -0.014826) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.343514));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.044494, 0.044494) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.282836));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.104003, 0.104003) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.106913));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.163901, 0.163901) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.018482));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.224285, 0.224285) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.001453));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.28125, 0.28125) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 4.5e-05));
  gl_FragData[0] = sum_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.254663, -0.254663) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000302);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.19403, -0.19403) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.00572));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.133895, -0.133895) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.049035));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.07421, -0.07421) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.1917));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.014826, -0.014826) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.343514));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.044494, 0.044494) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.282836));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.104003, 0.104003) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.106913));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.163901, 0.163901) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.018482));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.224285, 0.224285) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.001453));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.28125, 0.28125) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 4.5e-05));
  gl_FragData[0] = sum_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.254663, -0.254663) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000302);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.19403, -0.19403) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.00572));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.133895, -0.133895) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.049035));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.07421, -0.07421) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.1917));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.014826, -0.014826) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.343514));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.044494, 0.044494) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.282836));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.104003, 0.104003) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.106913));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.163901, 0.163901) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.018482));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.224285, 0.224285) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.001453));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.28125, 0.28125) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 4.5e-05));
  gl_FragData[0] = sum_2;
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
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 197901
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.954255, -0.954255) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 9.5e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.830891, -0.830891) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000603));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.707617, -0.707617) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.00297));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.584424, -0.584424) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.011339));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.461302, -0.461302) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.033529));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.338239, -0.338239) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.076812));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.215221, -0.215221) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.136344));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.092232, -0.092232) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.187531));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.030744, 0.030744) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.199876));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.153724, 0.153724) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.165082));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.276726, 0.276726) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.105653));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.399764, 0.399764) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.052393));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.522855, 0.522855) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.02013));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.646011, 0.646011) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.005992));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.769243, 0.769243) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.001381));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.892561, 0.892561) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.000247));
  _texcoord_1 = (xlv_TEXCOORD0 + _scaler);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 2.5e-05));
  gl_FragData[0] = sum_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.954255, -0.954255) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 9.5e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.830891, -0.830891) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000603));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.707617, -0.707617) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.00297));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.584424, -0.584424) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.011339));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.461302, -0.461302) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.033529));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.338239, -0.338239) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.076812));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.215221, -0.215221) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.136344));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.092232, -0.092232) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.187531));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.030744, 0.030744) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.199876));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.153724, 0.153724) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.165082));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.276726, 0.276726) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.105653));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.399764, 0.399764) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.052393));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.522855, 0.522855) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.02013));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.646011, 0.646011) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.005992));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.769243, 0.769243) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.001381));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.892561, 0.892561) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.000247));
  _texcoord_1 = (xlv_TEXCOORD0 + _scaler);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 2.5e-05));
  gl_FragData[0] = sum_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.954255, -0.954255) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 9.5e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.830891, -0.830891) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000603));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.707617, -0.707617) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.00297));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.584424, -0.584424) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.011339));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.461302, -0.461302) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.033529));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.338239, -0.338239) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.076812));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.215221, -0.215221) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.136344));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.092232, -0.092232) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.187531));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.030744, 0.030744) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.199876));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.153724, 0.153724) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.165082));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.276726, 0.276726) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.105653));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.399764, 0.399764) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.052393));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.522855, 0.522855) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.02013));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.646011, 0.646011) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.005992));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.769243, 0.769243) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.001381));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.892561, 0.892561) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.000247));
  _texcoord_1 = (xlv_TEXCOORD0 + _scaler);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 2.5e-05));
  gl_FragData[0] = sum_2;
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