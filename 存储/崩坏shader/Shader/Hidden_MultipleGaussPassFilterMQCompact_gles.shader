//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilterMQCompact" {
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
  GpuProgramID 43865
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.011912, -0.011912) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.008609);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.004764, -0.004764) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.308026));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.001547, 0.001547) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.607088));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.008234, 0.008234) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.075852));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.015625, 0.015625) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.000425));
  gl_FragData[0] = sum_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.011912, -0.011912) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.008609);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.004764, -0.004764) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.308026));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.001547, 0.001547) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.607088));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.008234, 0.008234) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.075852));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.015625, 0.015625) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.000425));
  gl_FragData[0] = sum_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.011912, -0.011912) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.008609);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.004764, -0.004764) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.308026));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.001547, 0.001547) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.607088));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.008234, 0.008234) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.075852));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.015625, 0.015625) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.000425));
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
  GpuProgramID 66906
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.047556, -0.047556) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.000394);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.032535, -0.032535) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.015949));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.017878, -0.017878) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.163609));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.003554, -0.003554) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.439939));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.010686, 0.010686) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.31658));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.025158, 0.025158) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.060512));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.040005, 0.040005) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.002982));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.054688, 0.054688) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 3.4e-05));
  gl_FragData[0] = sum_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.047556, -0.047556) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.000394);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.032535, -0.032535) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.015949));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.017878, -0.017878) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.163609));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.003554, -0.003554) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.439939));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.010686, 0.010686) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.31658));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.025158, 0.025158) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.060512));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.040005, 0.040005) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.002982));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.054688, 0.054688) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 3.4e-05));
  gl_FragData[0] = sum_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.047556, -0.047556) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.000394);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.032535, -0.032535) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.015949));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.017878, -0.017878) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.163609));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.003554, -0.003554) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.439939));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.010686, 0.010686) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.31658));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.025158, 0.025158) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.060512));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.040005, 0.040005) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.002982));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.054688, 0.054688) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 3.4e-05));
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
  GpuProgramID 175321
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.143376, -0.143376) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.000271);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.112941, -0.112941) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.003893));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.082662, -0.082662) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.029742));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.052524, -0.052524) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.12125));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.02249, -0.02249) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.264445));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.007495, 0.007495) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.30905));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.037498, 0.037498) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.193602));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.067578, 0.067578) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 0.064945));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.097783, 0.097783) * _scaler);
  highp vec2 result_37;
  result_37.x = (xlat_varinput_36.x * _CompactBloomSRCMapping.y);
  result_37.y = (xlat_varinput_36.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_37);
  highp vec2 UV_38;
  UV_38 = _texcoord_1;
  UV_38.x = (UV_38.x + _CompactBloomSRCMapping.x);
  UV_38.x = clamp (UV_38.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_38.y = clamp (UV_38.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_38;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_39 * 0.011641));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.128139, 0.128139) * _scaler);
  highp vec2 result_41;
  result_41.x = (xlat_varinput_40.x * _CompactBloomSRCMapping.y);
  result_41.y = (xlat_varinput_40.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_41);
  highp vec2 UV_42;
  UV_42 = _texcoord_1;
  UV_42.x = (UV_42.x + _CompactBloomSRCMapping.x);
  UV_42.x = clamp (UV_42.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_42.y = clamp (UV_42.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_43 * 0.001112));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.15625, 0.15625) * _scaler);
  highp vec2 result_45;
  result_45.x = (xlat_varinput_44.x * _CompactBloomSRCMapping.y);
  result_45.y = (xlat_varinput_44.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_45);
  highp vec2 UV_46;
  UV_46 = _texcoord_1;
  UV_46.x = (UV_46.x + _CompactBloomSRCMapping.x);
  UV_46.x = clamp (UV_46.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_46.y = clamp (UV_46.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_47 * 4.8e-05));
  gl_FragData[0] = sum_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.143376, -0.143376) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.000271);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.112941, -0.112941) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.003893));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.082662, -0.082662) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.029742));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.052524, -0.052524) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.12125));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.02249, -0.02249) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.264445));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.007495, 0.007495) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.30905));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.037498, 0.037498) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.193602));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.067578, 0.067578) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 0.064945));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.097783, 0.097783) * _scaler);
  highp vec2 result_37;
  result_37.x = (xlat_varinput_36.x * _CompactBloomSRCMapping.y);
  result_37.y = (xlat_varinput_36.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_37);
  highp vec2 UV_38;
  UV_38 = _texcoord_1;
  UV_38.x = (UV_38.x + _CompactBloomSRCMapping.x);
  UV_38.x = clamp (UV_38.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_38.y = clamp (UV_38.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_38;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_39 * 0.011641));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.128139, 0.128139) * _scaler);
  highp vec2 result_41;
  result_41.x = (xlat_varinput_40.x * _CompactBloomSRCMapping.y);
  result_41.y = (xlat_varinput_40.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_41);
  highp vec2 UV_42;
  UV_42 = _texcoord_1;
  UV_42.x = (UV_42.x + _CompactBloomSRCMapping.x);
  UV_42.x = clamp (UV_42.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_42.y = clamp (UV_42.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_43 * 0.001112));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.15625, 0.15625) * _scaler);
  highp vec2 result_45;
  result_45.x = (xlat_varinput_44.x * _CompactBloomSRCMapping.y);
  result_45.y = (xlat_varinput_44.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_45);
  highp vec2 UV_46;
  UV_46 = _texcoord_1;
  UV_46.x = (UV_46.x + _CompactBloomSRCMapping.x);
  UV_46.x = clamp (UV_46.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_46.y = clamp (UV_46.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_47 * 4.8e-05));
  gl_FragData[0] = sum_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.143376, -0.143376) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 0.000271);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.112941, -0.112941) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.003893));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.082662, -0.082662) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.029742));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.052524, -0.052524) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.12125));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.02249, -0.02249) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.264445));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.007495, 0.007495) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.30905));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.037498, 0.037498) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.193602));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.067578, 0.067578) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 0.064945));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.097783, 0.097783) * _scaler);
  highp vec2 result_37;
  result_37.x = (xlat_varinput_36.x * _CompactBloomSRCMapping.y);
  result_37.y = (xlat_varinput_36.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_37);
  highp vec2 UV_38;
  UV_38 = _texcoord_1;
  UV_38.x = (UV_38.x + _CompactBloomSRCMapping.x);
  UV_38.x = clamp (UV_38.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_38.y = clamp (UV_38.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_38;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_39 * 0.011641));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.128139, 0.128139) * _scaler);
  highp vec2 result_41;
  result_41.x = (xlat_varinput_40.x * _CompactBloomSRCMapping.y);
  result_41.y = (xlat_varinput_40.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_41);
  highp vec2 UV_42;
  UV_42 = _texcoord_1;
  UV_42.x = (UV_42.x + _CompactBloomSRCMapping.x);
  UV_42.x = clamp (UV_42.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_42.y = clamp (UV_42.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_43 * 0.001112));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.15625, 0.15625) * _scaler);
  highp vec2 result_45;
  result_45.x = (xlat_varinput_44.x * _CompactBloomSRCMapping.y);
  result_45.y = (xlat_varinput_44.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_45);
  highp vec2 UV_46;
  UV_46 = _texcoord_1;
  UV_46.x = (UV_46.x + _CompactBloomSRCMapping.x);
  UV_46.x = clamp (UV_46.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_46.y = clamp (UV_46.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_47 * 4.8e-05));
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
  GpuProgramID 225964
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.539947, -0.539947) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 4.9e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.478147, -0.478147) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.000291));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.416378, -0.416378) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.001383));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.354637, -0.354637) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.0053));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.292922, -0.292922) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.016378));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.231228, -0.231228) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.040822));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.169553, -0.169553) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.082068));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.107891, -0.107891) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 0.133082));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(-0.046237, -0.046237) * _scaler);
  highp vec2 result_37;
  result_37.x = (xlat_varinput_36.x * _CompactBloomSRCMapping.y);
  result_37.y = (xlat_varinput_36.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_37);
  highp vec2 UV_38;
  UV_38 = _texcoord_1;
  UV_38.x = (UV_38.x + _CompactBloomSRCMapping.x);
  UV_38.x = clamp (UV_38.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_38.y = clamp (UV_38.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_38;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_39 * 0.17408));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.015412, 0.015412) * _scaler);
  highp vec2 result_41;
  result_41.x = (xlat_varinput_40.x * _CompactBloomSRCMapping.y);
  result_41.y = (xlat_varinput_40.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_41);
  highp vec2 UV_42;
  UV_42 = _texcoord_1;
  UV_42.x = (UV_42.x + _CompactBloomSRCMapping.x);
  UV_42.x = clamp (UV_42.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_42.y = clamp (UV_42.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_43 * 0.183685));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.077063, 0.077063) * _scaler);
  highp vec2 result_45;
  result_45.x = (xlat_varinput_44.x * _CompactBloomSRCMapping.y);
  result_45.y = (xlat_varinput_44.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_45);
  highp vec2 UV_46;
  UV_46 = _texcoord_1;
  UV_46.x = (UV_46.x + _CompactBloomSRCMapping.x);
  UV_46.x = clamp (UV_46.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_46.y = clamp (UV_46.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_47 * 0.15635));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.13872, 0.13872) * _scaler);
  highp vec2 result_49;
  result_49.x = (xlat_varinput_48.x * _CompactBloomSRCMapping.y);
  result_49.y = (xlat_varinput_48.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_49);
  highp vec2 UV_50;
  UV_50 = _texcoord_1;
  UV_50.x = (UV_50.x + _CompactBloomSRCMapping.x);
  UV_50.x = clamp (UV_50.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_50.y = clamp (UV_50.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_50;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_51 * 0.107352));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.200388, 0.200388) * _scaler);
  highp vec2 result_53;
  result_53.x = (xlat_varinput_52.x * _CompactBloomSRCMapping.y);
  result_53.y = (xlat_varinput_52.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_53);
  highp vec2 UV_54;
  UV_54 = _texcoord_1;
  UV_54.x = (UV_54.x + _CompactBloomSRCMapping.x);
  UV_54.x = clamp (UV_54.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_54.y = clamp (UV_54.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_54;
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_55 * 0.059457));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.262072, 0.262072) * _scaler);
  highp vec2 result_57;
  result_57.x = (xlat_varinput_56.x * _CompactBloomSRCMapping.y);
  result_57.y = (xlat_varinput_56.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_57);
  highp vec2 UV_58;
  UV_58 = _texcoord_1;
  UV_58.x = (UV_58.x + _CompactBloomSRCMapping.x);
  UV_58.x = clamp (UV_58.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_58.y = clamp (UV_58.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_58;
  lowp vec4 tmpvar_59;
  tmpvar_59 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_59 * 0.026562));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.323776, 0.323776) * _scaler);
  highp vec2 result_61;
  result_61.x = (xlat_varinput_60.x * _CompactBloomSRCMapping.y);
  result_61.y = (xlat_varinput_60.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_61);
  highp vec2 UV_62;
  UV_62 = _texcoord_1;
  UV_62.x = (UV_62.x + _CompactBloomSRCMapping.x);
  UV_62.x = clamp (UV_62.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_62.y = clamp (UV_62.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_63 * 0.009571));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.385504, 0.385504) * _scaler);
  highp vec2 result_65;
  result_65.x = (xlat_varinput_64.x * _CompactBloomSRCMapping.y);
  result_65.y = (xlat_varinput_64.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_65);
  highp vec2 UV_66;
  UV_66 = _texcoord_1;
  UV_66.x = (UV_66.x + _CompactBloomSRCMapping.x);
  UV_66.x = clamp (UV_66.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_66.y = clamp (UV_66.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_66;
  lowp vec4 tmpvar_67;
  tmpvar_67 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_67 * 0.002781));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = (vec2(0.447258, 0.447258) * _scaler);
  highp vec2 result_69;
  result_69.x = (xlat_varinput_68.x * _CompactBloomSRCMapping.y);
  result_69.y = (xlat_varinput_68.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_69);
  highp vec2 UV_70;
  UV_70 = _texcoord_1;
  UV_70.x = (UV_70.x + _CompactBloomSRCMapping.x);
  UV_70.x = clamp (UV_70.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_70.y = clamp (UV_70.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_70;
  lowp vec4 tmpvar_71;
  tmpvar_71 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_71 * 0.000652));
  highp vec2 xlat_varinput_72;
  xlat_varinput_72 = (vec2(0.509043, 0.509043) * _scaler);
  highp vec2 result_73;
  result_73.x = (xlat_varinput_72.x * _CompactBloomSRCMapping.y);
  result_73.y = (xlat_varinput_72.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_73);
  highp vec2 UV_74;
  UV_74 = _texcoord_1;
  UV_74.x = (UV_74.x + _CompactBloomSRCMapping.x);
  UV_74.x = clamp (UV_74.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_74.y = clamp (UV_74.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_74;
  lowp vec4 tmpvar_75;
  tmpvar_75 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_75 * 0.000123));
  highp vec2 xlat_varinput_76;
  xlat_varinput_76 = (vec2(0.5625, 0.5625) * _scaler);
  highp vec2 result_77;
  result_77.x = (xlat_varinput_76.x * _CompactBloomSRCMapping.y);
  result_77.y = (xlat_varinput_76.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_77);
  highp vec2 UV_78;
  UV_78 = _texcoord_1;
  UV_78.x = (UV_78.x + _CompactBloomSRCMapping.x);
  UV_78.x = clamp (UV_78.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_78.y = clamp (UV_78.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_78;
  lowp vec4 tmpvar_79;
  tmpvar_79 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_79 * 1.4e-05));
  gl_FragData[0] = sum_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.539947, -0.539947) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 4.9e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.478147, -0.478147) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.000291));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.416378, -0.416378) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.001383));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.354637, -0.354637) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.0053));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.292922, -0.292922) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.016378));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.231228, -0.231228) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.040822));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.169553, -0.169553) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.082068));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.107891, -0.107891) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 0.133082));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(-0.046237, -0.046237) * _scaler);
  highp vec2 result_37;
  result_37.x = (xlat_varinput_36.x * _CompactBloomSRCMapping.y);
  result_37.y = (xlat_varinput_36.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_37);
  highp vec2 UV_38;
  UV_38 = _texcoord_1;
  UV_38.x = (UV_38.x + _CompactBloomSRCMapping.x);
  UV_38.x = clamp (UV_38.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_38.y = clamp (UV_38.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_38;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_39 * 0.17408));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.015412, 0.015412) * _scaler);
  highp vec2 result_41;
  result_41.x = (xlat_varinput_40.x * _CompactBloomSRCMapping.y);
  result_41.y = (xlat_varinput_40.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_41);
  highp vec2 UV_42;
  UV_42 = _texcoord_1;
  UV_42.x = (UV_42.x + _CompactBloomSRCMapping.x);
  UV_42.x = clamp (UV_42.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_42.y = clamp (UV_42.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_43 * 0.183685));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.077063, 0.077063) * _scaler);
  highp vec2 result_45;
  result_45.x = (xlat_varinput_44.x * _CompactBloomSRCMapping.y);
  result_45.y = (xlat_varinput_44.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_45);
  highp vec2 UV_46;
  UV_46 = _texcoord_1;
  UV_46.x = (UV_46.x + _CompactBloomSRCMapping.x);
  UV_46.x = clamp (UV_46.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_46.y = clamp (UV_46.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_47 * 0.15635));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.13872, 0.13872) * _scaler);
  highp vec2 result_49;
  result_49.x = (xlat_varinput_48.x * _CompactBloomSRCMapping.y);
  result_49.y = (xlat_varinput_48.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_49);
  highp vec2 UV_50;
  UV_50 = _texcoord_1;
  UV_50.x = (UV_50.x + _CompactBloomSRCMapping.x);
  UV_50.x = clamp (UV_50.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_50.y = clamp (UV_50.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_50;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_51 * 0.107352));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.200388, 0.200388) * _scaler);
  highp vec2 result_53;
  result_53.x = (xlat_varinput_52.x * _CompactBloomSRCMapping.y);
  result_53.y = (xlat_varinput_52.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_53);
  highp vec2 UV_54;
  UV_54 = _texcoord_1;
  UV_54.x = (UV_54.x + _CompactBloomSRCMapping.x);
  UV_54.x = clamp (UV_54.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_54.y = clamp (UV_54.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_54;
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_55 * 0.059457));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.262072, 0.262072) * _scaler);
  highp vec2 result_57;
  result_57.x = (xlat_varinput_56.x * _CompactBloomSRCMapping.y);
  result_57.y = (xlat_varinput_56.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_57);
  highp vec2 UV_58;
  UV_58 = _texcoord_1;
  UV_58.x = (UV_58.x + _CompactBloomSRCMapping.x);
  UV_58.x = clamp (UV_58.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_58.y = clamp (UV_58.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_58;
  lowp vec4 tmpvar_59;
  tmpvar_59 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_59 * 0.026562));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.323776, 0.323776) * _scaler);
  highp vec2 result_61;
  result_61.x = (xlat_varinput_60.x * _CompactBloomSRCMapping.y);
  result_61.y = (xlat_varinput_60.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_61);
  highp vec2 UV_62;
  UV_62 = _texcoord_1;
  UV_62.x = (UV_62.x + _CompactBloomSRCMapping.x);
  UV_62.x = clamp (UV_62.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_62.y = clamp (UV_62.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_63 * 0.009571));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.385504, 0.385504) * _scaler);
  highp vec2 result_65;
  result_65.x = (xlat_varinput_64.x * _CompactBloomSRCMapping.y);
  result_65.y = (xlat_varinput_64.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_65);
  highp vec2 UV_66;
  UV_66 = _texcoord_1;
  UV_66.x = (UV_66.x + _CompactBloomSRCMapping.x);
  UV_66.x = clamp (UV_66.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_66.y = clamp (UV_66.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_66;
  lowp vec4 tmpvar_67;
  tmpvar_67 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_67 * 0.002781));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = (vec2(0.447258, 0.447258) * _scaler);
  highp vec2 result_69;
  result_69.x = (xlat_varinput_68.x * _CompactBloomSRCMapping.y);
  result_69.y = (xlat_varinput_68.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_69);
  highp vec2 UV_70;
  UV_70 = _texcoord_1;
  UV_70.x = (UV_70.x + _CompactBloomSRCMapping.x);
  UV_70.x = clamp (UV_70.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_70.y = clamp (UV_70.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_70;
  lowp vec4 tmpvar_71;
  tmpvar_71 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_71 * 0.000652));
  highp vec2 xlat_varinput_72;
  xlat_varinput_72 = (vec2(0.509043, 0.509043) * _scaler);
  highp vec2 result_73;
  result_73.x = (xlat_varinput_72.x * _CompactBloomSRCMapping.y);
  result_73.y = (xlat_varinput_72.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_73);
  highp vec2 UV_74;
  UV_74 = _texcoord_1;
  UV_74.x = (UV_74.x + _CompactBloomSRCMapping.x);
  UV_74.x = clamp (UV_74.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_74.y = clamp (UV_74.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_74;
  lowp vec4 tmpvar_75;
  tmpvar_75 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_75 * 0.000123));
  highp vec2 xlat_varinput_76;
  xlat_varinput_76 = (vec2(0.5625, 0.5625) * _scaler);
  highp vec2 result_77;
  result_77.x = (xlat_varinput_76.x * _CompactBloomSRCMapping.y);
  result_77.y = (xlat_varinput_76.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_77);
  highp vec2 UV_78;
  UV_78 = _texcoord_1;
  UV_78.x = (UV_78.x + _CompactBloomSRCMapping.x);
  UV_78.x = clamp (UV_78.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_78.y = clamp (UV_78.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_78;
  lowp vec4 tmpvar_79;
  tmpvar_79 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_79 * 1.4e-05));
  gl_FragData[0] = sum_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _CompactBloomSRCMapping;
uniform highp vec4 _CompactBloomTARMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 1.0);
  highp vec2 tmpvar_3;
  tmpvar_3 = (_glesVertex.xy + 1.0);
  tmpvar_2.xy = (tmpvar_3 * 0.5);
  tmpvar_1.zw = tmpvar_2.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  highp vec2 xlat_varinput_5;
  xlat_varinput_5.x = (tmpvar_4.x * _CompactBloomSRCMapping.y);
  xlat_varinput_5.y = (tmpvar_4.y * _CompactBloomSRCMapping.z);
  highp vec2 xlat_varinput_6;
  xlat_varinput_6.x = ((tmpvar_2.x * _CompactBloomTARMapping.y) + _CompactBloomTARMapping.x);
  xlat_varinput_6.y = (tmpvar_2.y * _CompactBloomTARMapping.z);
  tmpvar_1.xy = ((xlat_varinput_6 * 2.0) - 1.0);
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = xlat_varinput_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec2 _scaler;
uniform highp vec4 _CompactBloomSRCMapping;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 _texcoord_1;
  mediump vec4 sum_2;
  highp vec2 xlat_varinput_3;
  xlat_varinput_3 = (vec2(-0.539947, -0.539947) * _scaler);
  highp vec2 result_4;
  result_4.x = (xlat_varinput_3.x * _CompactBloomSRCMapping.y);
  result_4.y = (xlat_varinput_3.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_4);
  highp vec2 UV_5;
  UV_5 = _texcoord_1;
  UV_5.x = (UV_5.x + _CompactBloomSRCMapping.x);
  highp float tmpvar_6;
  tmpvar_6 = (_CompactBloomSRCMapping.x + _CompactBloomSRCMapping.y);
  UV_5.x = clamp (UV_5.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_5.y = clamp (UV_5.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_5;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_7 * 4.9e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.478147, -0.478147) * _scaler);
  highp vec2 result_9;
  result_9.x = (xlat_varinput_8.x * _CompactBloomSRCMapping.y);
  result_9.y = (xlat_varinput_8.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_9);
  highp vec2 UV_10;
  UV_10 = _texcoord_1;
  UV_10.x = (UV_10.x + _CompactBloomSRCMapping.x);
  UV_10.x = clamp (UV_10.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_10.y = clamp (UV_10.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_11 * 0.000291));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.416378, -0.416378) * _scaler);
  highp vec2 result_13;
  result_13.x = (xlat_varinput_12.x * _CompactBloomSRCMapping.y);
  result_13.y = (xlat_varinput_12.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_13);
  highp vec2 UV_14;
  UV_14 = _texcoord_1;
  UV_14.x = (UV_14.x + _CompactBloomSRCMapping.x);
  UV_14.x = clamp (UV_14.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_14.y = clamp (UV_14.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_15 * 0.001383));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.354637, -0.354637) * _scaler);
  highp vec2 result_17;
  result_17.x = (xlat_varinput_16.x * _CompactBloomSRCMapping.y);
  result_17.y = (xlat_varinput_16.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_17);
  highp vec2 UV_18;
  UV_18 = _texcoord_1;
  UV_18.x = (UV_18.x + _CompactBloomSRCMapping.x);
  UV_18.x = clamp (UV_18.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_18.y = clamp (UV_18.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_19 * 0.0053));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.292922, -0.292922) * _scaler);
  highp vec2 result_21;
  result_21.x = (xlat_varinput_20.x * _CompactBloomSRCMapping.y);
  result_21.y = (xlat_varinput_20.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_21);
  highp vec2 UV_22;
  UV_22 = _texcoord_1;
  UV_22.x = (UV_22.x + _CompactBloomSRCMapping.x);
  UV_22.x = clamp (UV_22.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_22.y = clamp (UV_22.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_23 * 0.016378));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.231228, -0.231228) * _scaler);
  highp vec2 result_25;
  result_25.x = (xlat_varinput_24.x * _CompactBloomSRCMapping.y);
  result_25.y = (xlat_varinput_24.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_25);
  highp vec2 UV_26;
  UV_26 = _texcoord_1;
  UV_26.x = (UV_26.x + _CompactBloomSRCMapping.x);
  UV_26.x = clamp (UV_26.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_26.y = clamp (UV_26.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_27 * 0.040822));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.169553, -0.169553) * _scaler);
  highp vec2 result_29;
  result_29.x = (xlat_varinput_28.x * _CompactBloomSRCMapping.y);
  result_29.y = (xlat_varinput_28.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_29);
  highp vec2 UV_30;
  UV_30 = _texcoord_1;
  UV_30.x = (UV_30.x + _CompactBloomSRCMapping.x);
  UV_30.x = clamp (UV_30.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_30.y = clamp (UV_30.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_30;
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_31 * 0.082068));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.107891, -0.107891) * _scaler);
  highp vec2 result_33;
  result_33.x = (xlat_varinput_32.x * _CompactBloomSRCMapping.y);
  result_33.y = (xlat_varinput_32.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_33);
  highp vec2 UV_34;
  UV_34 = _texcoord_1;
  UV_34.x = (UV_34.x + _CompactBloomSRCMapping.x);
  UV_34.x = clamp (UV_34.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_34.y = clamp (UV_34.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_34;
  lowp vec4 tmpvar_35;
  tmpvar_35 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_35 * 0.133082));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(-0.046237, -0.046237) * _scaler);
  highp vec2 result_37;
  result_37.x = (xlat_varinput_36.x * _CompactBloomSRCMapping.y);
  result_37.y = (xlat_varinput_36.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_37);
  highp vec2 UV_38;
  UV_38 = _texcoord_1;
  UV_38.x = (UV_38.x + _CompactBloomSRCMapping.x);
  UV_38.x = clamp (UV_38.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_38.y = clamp (UV_38.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_38;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_39 * 0.17408));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.015412, 0.015412) * _scaler);
  highp vec2 result_41;
  result_41.x = (xlat_varinput_40.x * _CompactBloomSRCMapping.y);
  result_41.y = (xlat_varinput_40.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_41);
  highp vec2 UV_42;
  UV_42 = _texcoord_1;
  UV_42.x = (UV_42.x + _CompactBloomSRCMapping.x);
  UV_42.x = clamp (UV_42.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_42.y = clamp (UV_42.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_42;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_43 * 0.183685));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.077063, 0.077063) * _scaler);
  highp vec2 result_45;
  result_45.x = (xlat_varinput_44.x * _CompactBloomSRCMapping.y);
  result_45.y = (xlat_varinput_44.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_45);
  highp vec2 UV_46;
  UV_46 = _texcoord_1;
  UV_46.x = (UV_46.x + _CompactBloomSRCMapping.x);
  UV_46.x = clamp (UV_46.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_46.y = clamp (UV_46.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_46;
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_47 * 0.15635));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.13872, 0.13872) * _scaler);
  highp vec2 result_49;
  result_49.x = (xlat_varinput_48.x * _CompactBloomSRCMapping.y);
  result_49.y = (xlat_varinput_48.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_49);
  highp vec2 UV_50;
  UV_50 = _texcoord_1;
  UV_50.x = (UV_50.x + _CompactBloomSRCMapping.x);
  UV_50.x = clamp (UV_50.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_50.y = clamp (UV_50.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_50;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_51 * 0.107352));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.200388, 0.200388) * _scaler);
  highp vec2 result_53;
  result_53.x = (xlat_varinput_52.x * _CompactBloomSRCMapping.y);
  result_53.y = (xlat_varinput_52.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_53);
  highp vec2 UV_54;
  UV_54 = _texcoord_1;
  UV_54.x = (UV_54.x + _CompactBloomSRCMapping.x);
  UV_54.x = clamp (UV_54.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_54.y = clamp (UV_54.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_54;
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_55 * 0.059457));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.262072, 0.262072) * _scaler);
  highp vec2 result_57;
  result_57.x = (xlat_varinput_56.x * _CompactBloomSRCMapping.y);
  result_57.y = (xlat_varinput_56.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_57);
  highp vec2 UV_58;
  UV_58 = _texcoord_1;
  UV_58.x = (UV_58.x + _CompactBloomSRCMapping.x);
  UV_58.x = clamp (UV_58.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_58.y = clamp (UV_58.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_58;
  lowp vec4 tmpvar_59;
  tmpvar_59 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_59 * 0.026562));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.323776, 0.323776) * _scaler);
  highp vec2 result_61;
  result_61.x = (xlat_varinput_60.x * _CompactBloomSRCMapping.y);
  result_61.y = (xlat_varinput_60.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_61);
  highp vec2 UV_62;
  UV_62 = _texcoord_1;
  UV_62.x = (UV_62.x + _CompactBloomSRCMapping.x);
  UV_62.x = clamp (UV_62.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_62.y = clamp (UV_62.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_63 * 0.009571));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.385504, 0.385504) * _scaler);
  highp vec2 result_65;
  result_65.x = (xlat_varinput_64.x * _CompactBloomSRCMapping.y);
  result_65.y = (xlat_varinput_64.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_65);
  highp vec2 UV_66;
  UV_66 = _texcoord_1;
  UV_66.x = (UV_66.x + _CompactBloomSRCMapping.x);
  UV_66.x = clamp (UV_66.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_66.y = clamp (UV_66.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_66;
  lowp vec4 tmpvar_67;
  tmpvar_67 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_67 * 0.002781));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = (vec2(0.447258, 0.447258) * _scaler);
  highp vec2 result_69;
  result_69.x = (xlat_varinput_68.x * _CompactBloomSRCMapping.y);
  result_69.y = (xlat_varinput_68.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_69);
  highp vec2 UV_70;
  UV_70 = _texcoord_1;
  UV_70.x = (UV_70.x + _CompactBloomSRCMapping.x);
  UV_70.x = clamp (UV_70.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_70.y = clamp (UV_70.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_70;
  lowp vec4 tmpvar_71;
  tmpvar_71 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_71 * 0.000652));
  highp vec2 xlat_varinput_72;
  xlat_varinput_72 = (vec2(0.509043, 0.509043) * _scaler);
  highp vec2 result_73;
  result_73.x = (xlat_varinput_72.x * _CompactBloomSRCMapping.y);
  result_73.y = (xlat_varinput_72.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_73);
  highp vec2 UV_74;
  UV_74 = _texcoord_1;
  UV_74.x = (UV_74.x + _CompactBloomSRCMapping.x);
  UV_74.x = clamp (UV_74.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_74.y = clamp (UV_74.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_74;
  lowp vec4 tmpvar_75;
  tmpvar_75 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_75 * 0.000123));
  highp vec2 xlat_varinput_76;
  xlat_varinput_76 = (vec2(0.5625, 0.5625) * _scaler);
  highp vec2 result_77;
  result_77.x = (xlat_varinput_76.x * _CompactBloomSRCMapping.y);
  result_77.y = (xlat_varinput_76.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_77);
  highp vec2 UV_78;
  UV_78 = _texcoord_1;
  UV_78.x = (UV_78.x + _CompactBloomSRCMapping.x);
  UV_78.x = clamp (UV_78.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_78.y = clamp (UV_78.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_78;
  lowp vec4 tmpvar_79;
  tmpvar_79 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_79 * 1.4e-05));
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