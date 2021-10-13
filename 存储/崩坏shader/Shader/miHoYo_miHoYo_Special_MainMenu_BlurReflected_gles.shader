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
uniform mediump vec4 _offset_4_1;
uniform mediump vec4 _offset_4_2;
uniform mediump vec4 _weights;
uniform mediump vec4 _offset_4_3;
uniform mediump vec4 _offset_4_4;
uniform mediump vec4 _weights2;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_1.xy * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * _weights.x);
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_1.zw * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * _weights.y));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_2.xy * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * _weights.z));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_2.zw * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * _weights.w));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_3.xy * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * _weights2.x));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_3.zw * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * _weights2.y));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_4.xy * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * _weights2.z));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_4.zw * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * _weights2.w));
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
uniform mediump vec4 _offset_4_1;
uniform mediump vec4 _offset_4_2;
uniform mediump vec4 _weights;
uniform mediump vec4 _offset_4_3;
uniform mediump vec4 _offset_4_4;
uniform mediump vec4 _weights2;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_1.xy * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * _weights.x);
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_1.zw * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * _weights.y));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_2.xy * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * _weights.z));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_2.zw * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * _weights.w));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_3.xy * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * _weights2.x));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_3.zw * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * _weights2.y));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_4.xy * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * _weights2.z));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_4.zw * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * _weights2.w));
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
uniform mediump vec4 _offset_4_1;
uniform mediump vec4 _offset_4_2;
uniform mediump vec4 _weights;
uniform mediump vec4 _offset_4_3;
uniform mediump vec4 _offset_4_4;
uniform mediump vec4 _weights2;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_1.xy * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3 * _weights.x);
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_1.zw * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4 * _weights.y));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_2.xy * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5 * _weights.z));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_2.zw * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6 * _weights.w));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_3.xy * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7 * _weights2.x));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_3.zw * _scaler));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_8 * _weights2.y));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_4.xy * _scaler));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_9 * _weights2.z));
  _texcoord_1 = (xlv_TEXCOORD0 + (_offset_4_4.zw * _scaler));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_10 * _weights2.w));
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