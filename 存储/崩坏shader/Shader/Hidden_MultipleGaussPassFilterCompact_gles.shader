//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilterCompact" {
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
  GpuProgramID 17671
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
  xlat_varinput_3 = (vec2(-0.015931, -0.015931) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.036315);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.002697, -0.002697) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.689368));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.008811, 0.008811) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.272895));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.023438, 0.023438) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.001422));
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
  xlat_varinput_3 = (vec2(-0.015931, -0.015931) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.036315);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.002697, -0.002697) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.689368));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.008811, 0.008811) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.272895));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.023438, 0.023438) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.001422));
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
  xlat_varinput_3 = (vec2(-0.015931, -0.015931) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.036315);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.002697, -0.002697) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.689368));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.008811, 0.008811) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.272895));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.023438, 0.023438) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.001422));
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
  GpuProgramID 83561
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
  xlat_varinput_3 = (vec2(-0.079645, -0.079645) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.00178);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.049923, -0.049923) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.050978));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.021135, -0.021135) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.320296));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.007024, 0.007024) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.461242));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.035414, 0.035414) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.15398));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.064674, 0.064674) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.01155));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.09375, 0.09375) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.000173));
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
  xlat_varinput_3 = (vec2(-0.079645, -0.079645) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.00178);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.049923, -0.049923) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.050978));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.021135, -0.021135) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.320296));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.007024, 0.007024) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.461242));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.035414, 0.035414) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.15398));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.064674, 0.064674) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.01155));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.09375, 0.09375) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.000173));
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
  xlat_varinput_3 = (vec2(-0.079645, -0.079645) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.00178);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.049923, -0.049923) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.050978));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.021135, -0.021135) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.320296));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.007024, 0.007024) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.461242));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.035414, 0.035414) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.15398));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.064674, 0.064674) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.01155));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.09375, 0.09375) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.000173));
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
  GpuProgramID 143652
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
  xlat_varinput_3 = (vec2(-0.254663, -0.254663) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.000302);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.19403, -0.19403) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.00572));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.133895, -0.133895) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.049035));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.07421, -0.07421) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.1917));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.014826, -0.014826) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.343514));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.044494, 0.044494) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.282836));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.104003, 0.104003) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.106913));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.163901, 0.163901) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.018482));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.224285, 0.224285) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.001453));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.28125, 0.28125) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 4.5e-05));
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
  xlat_varinput_3 = (vec2(-0.254663, -0.254663) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.000302);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.19403, -0.19403) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.00572));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.133895, -0.133895) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.049035));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.07421, -0.07421) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.1917));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.014826, -0.014826) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.343514));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.044494, 0.044494) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.282836));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.104003, 0.104003) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.106913));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.163901, 0.163901) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.018482));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.224285, 0.224285) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.001453));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.28125, 0.28125) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 4.5e-05));
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
  xlat_varinput_3 = (vec2(-0.254663, -0.254663) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.000302);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.19403, -0.19403) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.00572));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.133895, -0.133895) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.049035));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.07421, -0.07421) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.1917));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.014826, -0.014826) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.343514));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.044494, 0.044494) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.282836));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.104003, 0.104003) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.106913));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.163901, 0.163901) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.018482));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.224285, 0.224285) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.001453));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.28125, 0.28125) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 4.5e-05));
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
  GpuProgramID 255667
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
  xlat_varinput_3 = (vec2(-0.954255, -0.954255) * _scaler);
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
  sum_2 = (tmpvar_7 * 9.5e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.830891, -0.830891) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.000603));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.707617, -0.707617) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.00297));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.584424, -0.584424) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.011339));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.461302, -0.461302) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.033529));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.338239, -0.338239) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.076812));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.215221, -0.215221) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.136344));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.092232, -0.092232) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.187531));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.030744, 0.030744) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.199876));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.153724, 0.153724) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.165082));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.276726, 0.276726) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.105653));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.399764, 0.399764) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.052393));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.522855, 0.522855) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 0.02013));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.646011, 0.646011) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_59 * 0.005992));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.769243, 0.769243) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_63 * 0.001381));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.892561, 0.892561) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_67 * 0.000247));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = _scaler;
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
  sum_2 = (sum_2 + (tmpvar_71 * 2.5e-05));
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
  xlat_varinput_3 = (vec2(-0.954255, -0.954255) * _scaler);
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
  sum_2 = (tmpvar_7 * 9.5e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.830891, -0.830891) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.000603));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.707617, -0.707617) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.00297));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.584424, -0.584424) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.011339));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.461302, -0.461302) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.033529));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.338239, -0.338239) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.076812));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.215221, -0.215221) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.136344));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.092232, -0.092232) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.187531));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.030744, 0.030744) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.199876));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.153724, 0.153724) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.165082));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.276726, 0.276726) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.105653));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.399764, 0.399764) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.052393));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.522855, 0.522855) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 0.02013));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.646011, 0.646011) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_59 * 0.005992));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.769243, 0.769243) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_63 * 0.001381));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.892561, 0.892561) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_67 * 0.000247));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = _scaler;
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
  sum_2 = (sum_2 + (tmpvar_71 * 2.5e-05));
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
  xlat_varinput_3 = (vec2(-0.954255, -0.954255) * _scaler);
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
  sum_2 = (tmpvar_7 * 9.5e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.830891, -0.830891) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.000603));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.707617, -0.707617) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.00297));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.584424, -0.584424) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.011339));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.461302, -0.461302) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.033529));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.338239, -0.338239) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.076812));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.215221, -0.215221) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.136344));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.092232, -0.092232) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.187531));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.030744, 0.030744) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.199876));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.153724, 0.153724) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.165082));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.276726, 0.276726) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.105653));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.399764, 0.399764) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.052393));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.522855, 0.522855) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 0.02013));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.646011, 0.646011) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_59 * 0.005992));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.769243, 0.769243) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_63 * 0.001381));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.892561, 0.892561) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_67 * 0.000247));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = _scaler;
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
  sum_2 = (sum_2 + (tmpvar_71 * 2.5e-05));
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