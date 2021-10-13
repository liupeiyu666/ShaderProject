//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilterHQ" {
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
  GpuProgramID 37791
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.005921, -0.005921) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.004956);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.002318, -0.002318) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.297577));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.000742, 0.000742) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.636881));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.004061, 0.004061) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.06043));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007813, 0.007813) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.000155));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.005921, -0.005921) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.004956);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.002318, -0.002318) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.297577));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.000742, 0.000742) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.636881));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.004061, 0.004061) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.06043));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007813, 0.007813) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.000155));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.005921, -0.005921) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.004956);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.002318, -0.002318) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.297577));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.000742, 0.000742) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.636881));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.004061, 0.004061) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.06043));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.007813, 0.007813) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.000155));
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
  GpuProgramID 72202
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.023871, -0.023871) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.0008);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.016373, -0.016373) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.02158));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.009024, -0.009024) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.172469));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.001797, -0.001797) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.417991));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.005399, 0.005399) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.311311));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.01268, 0.01268) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.070916));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.020105, 0.020105) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.004845));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.027344, 0.027344) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 8.9e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.023871, -0.023871) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.0008);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.016373, -0.016373) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.02158));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.009024, -0.009024) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.172469));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.001797, -0.001797) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.417991));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.005399, 0.005399) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.311311));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.01268, 0.01268) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.070916));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.020105, 0.020105) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.004845));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.027344, 0.027344) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 8.9e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.023871, -0.023871) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 0.0008);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.016373, -0.016373) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.02158));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.009024, -0.009024) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.172469));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.001797, -0.001797) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.417991));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.005399, 0.005399) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.311311));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.01268, 0.01268) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.070916));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.020105, 0.020105) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.004845));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.027344, 0.027344) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 8.9e-05));
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
  GpuProgramID 177243
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.087437, -0.087437) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 9.1e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.072138, -0.072138) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.001165));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.056886, -0.056886) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.00918));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.041676, -0.041676) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.044432));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.026503, -0.026503) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.132256));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.011354, -0.011354) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.242352));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.003784, 0.003784) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.273552));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.018926, 0.018926) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.190216));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.034086, 0.034086) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.081454));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.049276, 0.049276) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.021463));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.064507, 0.064507) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.003476));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.079782, 0.079782) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.000346));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.09375, 0.09375) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 1.7e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.087437, -0.087437) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 9.1e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.072138, -0.072138) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.001165));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.056886, -0.056886) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.00918));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.041676, -0.041676) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.044432));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.026503, -0.026503) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.132256));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.011354, -0.011354) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.242352));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.003784, 0.003784) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.273552));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.018926, 0.018926) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.190216));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.034086, 0.034086) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.081454));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.049276, 0.049276) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.021463));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.064507, 0.064507) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.003476));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.079782, 0.079782) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.000346));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.09375, 0.09375) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 1.7e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.087437, -0.087437) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 9.1e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.072138, -0.072138) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.001165));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.056886, -0.056886) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.00918));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.041676, -0.041676) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.044432));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.026503, -0.026503) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.132256));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.011354, -0.011354) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.242352));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.003784, 0.003784) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.273552));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.018926, 0.018926) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.190216));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.034086, 0.034086) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.081454));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.049276, 0.049276) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.021463));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.064507, 0.064507) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.003476));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.079782, 0.079782) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.000346));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.09375, 0.09375) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 1.7e-05));
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
  GpuProgramID 214037
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.285986, -0.285986) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 8.3e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.255038, -0.255038) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000394));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.2241, -0.2241) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.001564));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.193171, -0.193171) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.005203));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.16225, -0.16225) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.014481));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.131336, -0.131336) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.03373));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.100428, -0.100428) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.06575));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.069524, -0.069524) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.107267));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.038624, -0.038624) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.146464));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.007725, -0.007725) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.16738));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.023174, 0.023174) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.160096));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.054074, 0.054074) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.128163));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.084976, 0.084976) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.08587));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.115882, 0.115882) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.048152));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.146793, 0.146793) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.022598));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.17771, 0.17771) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.008876));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.208635, 0.208635) * _scaler));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.002917));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.239568, 0.239568) * _scaler));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_20 * 0.000802));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.270511, 0.270511) * _scaler));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_21 * 0.000185));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.296875, 0.296875) * _scaler));
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_22 * 2.5e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.285986, -0.285986) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 8.3e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.255038, -0.255038) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000394));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.2241, -0.2241) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.001564));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.193171, -0.193171) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.005203));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.16225, -0.16225) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.014481));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.131336, -0.131336) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.03373));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.100428, -0.100428) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.06575));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.069524, -0.069524) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.107267));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.038624, -0.038624) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.146464));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.007725, -0.007725) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.16738));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.023174, 0.023174) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.160096));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.054074, 0.054074) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.128163));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.084976, 0.084976) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.08587));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.115882, 0.115882) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.048152));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.146793, 0.146793) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.022598));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.17771, 0.17771) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.008876));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.208635, 0.208635) * _scaler));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.002917));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.239568, 0.239568) * _scaler));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_20 * 0.000802));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.270511, 0.270511) * _scaler));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_21 * 0.000185));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.296875, 0.296875) * _scaler));
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_22 * 2.5e-05));
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
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.285986, -0.285986) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * 8.3e-05);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.255038, -0.255038) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * 0.000394));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.2241, -0.2241) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * 0.001564));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.193171, -0.193171) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * 0.005203));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.16225, -0.16225) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * 0.014481));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.131336, -0.131336) * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * 0.03373));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.100428, -0.100428) * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * 0.06575));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.069524, -0.069524) * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * 0.107267));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.038624, -0.038624) * _scaler));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.146464));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.007725, -0.007725) * _scaler));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_12 * 0.16738));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.023174, 0.023174) * _scaler));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_13 * 0.160096));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.054074, 0.054074) * _scaler));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_14 * 0.128163));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.084976, 0.084976) * _scaler));
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.08587));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.115882, 0.115882) * _scaler));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_16 * 0.048152));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.146793, 0.146793) * _scaler));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_17 * 0.022598));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.17771, 0.17771) * _scaler));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_18 * 0.008876));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.208635, 0.208635) * _scaler));
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.002917));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.239568, 0.239568) * _scaler));
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_20 * 0.000802));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.270511, 0.270511) * _scaler));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_21 * 0.000185));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.296875, 0.296875) * _scaler));
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_22 * 2.5e-05));
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