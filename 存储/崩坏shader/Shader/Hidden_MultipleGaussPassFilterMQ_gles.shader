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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.011912, -0.011912) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.008609);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.004764, -0.004764) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.308026));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.001547, 0.001547) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.607088));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.008234, 0.008234) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.075852));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.015625, 0.015625) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.000425));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.011912, -0.011912) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.008609);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.004764, -0.004764) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.308026));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.001547, 0.001547) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.607088));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.008234, 0.008234) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.075852));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.015625, 0.015625) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.000425));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.011912, -0.011912) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.008609);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.004764, -0.004764) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.308026));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.001547, 0.001547) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.607088));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.008234, 0.008234) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.075852));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.015625, 0.015625) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.000425));
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
  GpuProgramID 82644
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.047556, -0.047556) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000394);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.032535, -0.032535) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.015949));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.017878, -0.017878) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.163609));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.003554, -0.003554) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.439939));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.010686, 0.010686) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.31658));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.025158, 0.025158) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.060512));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.040005, 0.040005) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.002982));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.054688, 0.054688) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 3.4e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.047556, -0.047556) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000394);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.032535, -0.032535) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.015949));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.017878, -0.017878) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.163609));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.003554, -0.003554) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.439939));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.010686, 0.010686) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.31658));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.025158, 0.025158) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.060512));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.040005, 0.040005) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.002982));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.054688, 0.054688) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 3.4e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.047556, -0.047556) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000394);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.032535, -0.032535) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.015949));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.017878, -0.017878) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.163609));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.003554, -0.003554) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.439939));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.010686, 0.010686) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.31658));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.025158, 0.025158) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.060512));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.040005, 0.040005) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.002982));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.054688, 0.054688) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 3.4e-05));
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
  GpuProgramID 133408
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.143376, -0.143376) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000271);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.112941, -0.112941) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.003893));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.082662, -0.082662) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.029742));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.052524, -0.052524) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.12125));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.02249, -0.02249) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.264445));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007495, 0.007495) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.30905));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.037498, 0.037498) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.193602));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.067578, 0.067578) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.064945));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.097783, 0.097783) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.011641));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.128139, 0.128139) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.001112));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.15625, 0.15625) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 4.8e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.143376, -0.143376) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000271);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.112941, -0.112941) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.003893));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.082662, -0.082662) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.029742));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.052524, -0.052524) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.12125));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.02249, -0.02249) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.264445));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007495, 0.007495) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.30905));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.037498, 0.037498) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.193602));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.067578, 0.067578) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.064945));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.097783, 0.097783) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.011641));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.128139, 0.128139) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.001112));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.15625, 0.15625) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 4.8e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.143376, -0.143376) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.000271);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.112941, -0.112941) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.003893));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.082662, -0.082662) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.029742));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.052524, -0.052524) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.12125));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.02249, -0.02249) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.264445));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007495, 0.007495) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.30905));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.037498, 0.037498) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.193602));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.067578, 0.067578) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.064945));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.097783, 0.097783) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.011641));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.128139, 0.128139) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.001112));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.15625, 0.15625) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 4.8e-05));
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
  GpuProgramID 257965
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.539947, -0.539947) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 4.9e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.478147, -0.478147) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000291));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.416378, -0.416378) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.001383));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.354637, -0.354637) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.0053));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.292922, -0.292922) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.016378));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.231228, -0.231228) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.040822));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.169553, -0.169553) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.082068));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.107891, -0.107891) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.133082));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.046237, -0.046237) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.17408));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.015412, 0.015412) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.183685));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.077063, 0.077063) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.15635));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.13872, 0.13872) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.107352));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.200388, 0.200388) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.059457));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.262072, 0.262072) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.026562));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.323776, 0.323776) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.009571));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.385504, 0.385504) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.002781));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.447258, 0.447258) * _scaler));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.000652));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.509043, 0.509043) * _scaler));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_20 * 0.000123));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.5625, 0.5625) * _scaler));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_21 * 1.4e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.539947, -0.539947) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 4.9e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.478147, -0.478147) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000291));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.416378, -0.416378) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.001383));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.354637, -0.354637) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.0053));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.292922, -0.292922) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.016378));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.231228, -0.231228) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.040822));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.169553, -0.169553) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.082068));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.107891, -0.107891) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.133082));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.046237, -0.046237) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.17408));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.015412, 0.015412) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.183685));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.077063, 0.077063) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.15635));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.13872, 0.13872) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.107352));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.200388, 0.200388) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.059457));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.262072, 0.262072) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.026562));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.323776, 0.323776) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.009571));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.385504, 0.385504) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.002781));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.447258, 0.447258) * _scaler));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.000652));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.509043, 0.509043) * _scaler));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_20 * 0.000123));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.5625, 0.5625) * _scaler));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_21 * 1.4e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.539947, -0.539947) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 4.9e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.478147, -0.478147) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000291));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.416378, -0.416378) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.001383));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.354637, -0.354637) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.0053));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.292922, -0.292922) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.016378));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.231228, -0.231228) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.040822));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.169553, -0.169553) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.082068));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.107891, -0.107891) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.133082));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.046237, -0.046237) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.17408));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.015412, 0.015412) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.183685));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.077063, 0.077063) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.15635));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.13872, 0.13872) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.107352));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.200388, 0.200388) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.059457));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.262072, 0.262072) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.026562));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.323776, 0.323776) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.009571));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.385504, 0.385504) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.002781));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.447258, 0.447258) * _scaler));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.000652));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.509043, 0.509043) * _scaler));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_20 * 0.000123));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.5625, 0.5625) * _scaler));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_21 * 1.4e-05));
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