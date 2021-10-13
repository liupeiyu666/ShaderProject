//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/MultipleGaussPassFilterHQCompact" {
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
  GpuProgramID 24182
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
  xlat_varinput_3 = (vec2(-0.005921, -0.005921) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.004956);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.002318, -0.002318) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.297577));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.000742, 0.000742) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.636881));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.004061, 0.004061) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.06043));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.007813, 0.007813) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.000155));
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
  xlat_varinput_3 = (vec2(-0.005921, -0.005921) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.004956);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.002318, -0.002318) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.297577));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.000742, 0.000742) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.636881));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.004061, 0.004061) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.06043));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.007813, 0.007813) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.000155));
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
  xlat_varinput_3 = (vec2(-0.005921, -0.005921) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.004956);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.002318, -0.002318) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.297577));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(0.000742, 0.000742) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.636881));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(0.004061, 0.004061) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.06043));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.007813, 0.007813) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.000155));
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
  GpuProgramID 112056
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
  xlat_varinput_3 = (vec2(-0.023871, -0.023871) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.0008);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.016373, -0.016373) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.02158));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.009024, -0.009024) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.172469));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.001797, -0.001797) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.417991));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.005399, 0.005399) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.311311));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.01268, 0.01268) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.070916));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.020105, 0.020105) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.004845));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.027344, 0.027344) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 8.9e-05));
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
  xlat_varinput_3 = (vec2(-0.023871, -0.023871) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.0008);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.016373, -0.016373) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.02158));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.009024, -0.009024) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.172469));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.001797, -0.001797) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.417991));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.005399, 0.005399) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.311311));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.01268, 0.01268) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.070916));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.020105, 0.020105) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.004845));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.027344, 0.027344) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 8.9e-05));
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
  xlat_varinput_3 = (vec2(-0.023871, -0.023871) * _scaler);
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
  sum_2 = (tmpvar_7 * 0.0008);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.016373, -0.016373) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.02158));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.009024, -0.009024) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.172469));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.001797, -0.001797) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.417991));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(0.005399, 0.005399) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.311311));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(0.01268, 0.01268) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.070916));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.020105, 0.020105) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.004845));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.027344, 0.027344) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 8.9e-05));
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
  GpuProgramID 195254
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
  xlat_varinput_3 = (vec2(-0.087437, -0.087437) * _scaler);
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
  sum_2 = (tmpvar_7 * 9.1e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.072138, -0.072138) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.001165));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.056886, -0.056886) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.00918));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.041676, -0.041676) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.044432));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.026503, -0.026503) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.132256));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.011354, -0.011354) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.242352));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.003784, 0.003784) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.273552));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.018926, 0.018926) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.190216));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.034086, 0.034086) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.081454));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.049276, 0.049276) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.021463));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.064507, 0.064507) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.003476));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.079782, 0.079782) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.000346));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.09375, 0.09375) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 1.7e-05));
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
  xlat_varinput_3 = (vec2(-0.087437, -0.087437) * _scaler);
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
  sum_2 = (tmpvar_7 * 9.1e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.072138, -0.072138) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.001165));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.056886, -0.056886) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.00918));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.041676, -0.041676) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.044432));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.026503, -0.026503) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.132256));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.011354, -0.011354) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.242352));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.003784, 0.003784) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.273552));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.018926, 0.018926) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.190216));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.034086, 0.034086) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.081454));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.049276, 0.049276) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.021463));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.064507, 0.064507) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.003476));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.079782, 0.079782) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.000346));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.09375, 0.09375) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 1.7e-05));
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
  xlat_varinput_3 = (vec2(-0.087437, -0.087437) * _scaler);
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
  sum_2 = (tmpvar_7 * 9.1e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.072138, -0.072138) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.001165));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.056886, -0.056886) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.00918));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.041676, -0.041676) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.044432));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.026503, -0.026503) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.132256));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.011354, -0.011354) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.242352));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(0.003784, 0.003784) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.273552));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(0.018926, 0.018926) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.190216));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(0.034086, 0.034086) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.081454));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(0.049276, 0.049276) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.021463));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.064507, 0.064507) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.003476));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.079782, 0.079782) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.000346));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.09375, 0.09375) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 1.7e-05));
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
  GpuProgramID 220840
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
  xlat_varinput_3 = (vec2(-0.285986, -0.285986) * _scaler);
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
  sum_2 = (tmpvar_7 * 8.3e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.255038, -0.255038) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.000394));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.2241, -0.2241) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.001564));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.193171, -0.193171) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.005203));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.16225, -0.16225) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.014481));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.131336, -0.131336) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.03373));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.100428, -0.100428) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.06575));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.069524, -0.069524) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.107267));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(-0.038624, -0.038624) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.146464));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(-0.007725, -0.007725) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.16738));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.023174, 0.023174) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.160096));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.054074, 0.054074) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.128163));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.084976, 0.084976) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 0.08587));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.115882, 0.115882) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_59 * 0.048152));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.146793, 0.146793) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_63 * 0.022598));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.17771, 0.17771) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_67 * 0.008876));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = (vec2(0.208635, 0.208635) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_71 * 0.002917));
  highp vec2 xlat_varinput_72;
  xlat_varinput_72 = (vec2(0.239568, 0.239568) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_75 * 0.000802));
  highp vec2 xlat_varinput_76;
  xlat_varinput_76 = (vec2(0.270511, 0.270511) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_79 * 0.000185));
  highp vec2 xlat_varinput_80;
  xlat_varinput_80 = (vec2(0.296875, 0.296875) * _scaler);
  highp vec2 result_81;
  result_81.x = (xlat_varinput_80.x * _CompactBloomSRCMapping.y);
  result_81.y = (xlat_varinput_80.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_81);
  highp vec2 UV_82;
  UV_82 = _texcoord_1;
  UV_82.x = (UV_82.x + _CompactBloomSRCMapping.x);
  UV_82.x = clamp (UV_82.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_82.y = clamp (UV_82.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_82;
  lowp vec4 tmpvar_83;
  tmpvar_83 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_83 * 2.5e-05));
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
  xlat_varinput_3 = (vec2(-0.285986, -0.285986) * _scaler);
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
  sum_2 = (tmpvar_7 * 8.3e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.255038, -0.255038) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.000394));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.2241, -0.2241) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.001564));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.193171, -0.193171) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.005203));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.16225, -0.16225) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.014481));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.131336, -0.131336) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.03373));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.100428, -0.100428) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.06575));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.069524, -0.069524) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.107267));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(-0.038624, -0.038624) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.146464));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(-0.007725, -0.007725) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.16738));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.023174, 0.023174) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.160096));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.054074, 0.054074) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.128163));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.084976, 0.084976) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 0.08587));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.115882, 0.115882) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_59 * 0.048152));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.146793, 0.146793) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_63 * 0.022598));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.17771, 0.17771) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_67 * 0.008876));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = (vec2(0.208635, 0.208635) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_71 * 0.002917));
  highp vec2 xlat_varinput_72;
  xlat_varinput_72 = (vec2(0.239568, 0.239568) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_75 * 0.000802));
  highp vec2 xlat_varinput_76;
  xlat_varinput_76 = (vec2(0.270511, 0.270511) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_79 * 0.000185));
  highp vec2 xlat_varinput_80;
  xlat_varinput_80 = (vec2(0.296875, 0.296875) * _scaler);
  highp vec2 result_81;
  result_81.x = (xlat_varinput_80.x * _CompactBloomSRCMapping.y);
  result_81.y = (xlat_varinput_80.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_81);
  highp vec2 UV_82;
  UV_82 = _texcoord_1;
  UV_82.x = (UV_82.x + _CompactBloomSRCMapping.x);
  UV_82.x = clamp (UV_82.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_82.y = clamp (UV_82.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_82;
  lowp vec4 tmpvar_83;
  tmpvar_83 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_83 * 2.5e-05));
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
  xlat_varinput_3 = (vec2(-0.285986, -0.285986) * _scaler);
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
  sum_2 = (tmpvar_7 * 8.3e-05);
  highp vec2 xlat_varinput_8;
  xlat_varinput_8 = (vec2(-0.255038, -0.255038) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_11 * 0.000394));
  highp vec2 xlat_varinput_12;
  xlat_varinput_12 = (vec2(-0.2241, -0.2241) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_15 * 0.001564));
  highp vec2 xlat_varinput_16;
  xlat_varinput_16 = (vec2(-0.193171, -0.193171) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_19 * 0.005203));
  highp vec2 xlat_varinput_20;
  xlat_varinput_20 = (vec2(-0.16225, -0.16225) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_23 * 0.014481));
  highp vec2 xlat_varinput_24;
  xlat_varinput_24 = (vec2(-0.131336, -0.131336) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_27 * 0.03373));
  highp vec2 xlat_varinput_28;
  xlat_varinput_28 = (vec2(-0.100428, -0.100428) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_31 * 0.06575));
  highp vec2 xlat_varinput_32;
  xlat_varinput_32 = (vec2(-0.069524, -0.069524) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_35 * 0.107267));
  highp vec2 xlat_varinput_36;
  xlat_varinput_36 = (vec2(-0.038624, -0.038624) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_39 * 0.146464));
  highp vec2 xlat_varinput_40;
  xlat_varinput_40 = (vec2(-0.007725, -0.007725) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_43 * 0.16738));
  highp vec2 xlat_varinput_44;
  xlat_varinput_44 = (vec2(0.023174, 0.023174) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_47 * 0.160096));
  highp vec2 xlat_varinput_48;
  xlat_varinput_48 = (vec2(0.054074, 0.054074) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_51 * 0.128163));
  highp vec2 xlat_varinput_52;
  xlat_varinput_52 = (vec2(0.084976, 0.084976) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_55 * 0.08587));
  highp vec2 xlat_varinput_56;
  xlat_varinput_56 = (vec2(0.115882, 0.115882) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_59 * 0.048152));
  highp vec2 xlat_varinput_60;
  xlat_varinput_60 = (vec2(0.146793, 0.146793) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_63 * 0.022598));
  highp vec2 xlat_varinput_64;
  xlat_varinput_64 = (vec2(0.17771, 0.17771) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_67 * 0.008876));
  highp vec2 xlat_varinput_68;
  xlat_varinput_68 = (vec2(0.208635, 0.208635) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_71 * 0.002917));
  highp vec2 xlat_varinput_72;
  xlat_varinput_72 = (vec2(0.239568, 0.239568) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_75 * 0.000802));
  highp vec2 xlat_varinput_76;
  xlat_varinput_76 = (vec2(0.270511, 0.270511) * _scaler);
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
  sum_2 = (sum_2 + (tmpvar_79 * 0.000185));
  highp vec2 xlat_varinput_80;
  xlat_varinput_80 = (vec2(0.296875, 0.296875) * _scaler);
  highp vec2 result_81;
  result_81.x = (xlat_varinput_80.x * _CompactBloomSRCMapping.y);
  result_81.y = (xlat_varinput_80.y * _CompactBloomSRCMapping.z);
  _texcoord_1 = (xlv_TEXCOORD0 + result_81);
  highp vec2 UV_82;
  UV_82 = _texcoord_1;
  UV_82.x = (UV_82.x + _CompactBloomSRCMapping.x);
  UV_82.x = clamp (UV_82.x, _CompactBloomSRCMapping.x, tmpvar_6);
  UV_82.y = clamp (UV_82.y, 0.0, _CompactBloomSRCMapping.z);
  _texcoord_1 = UV_82;
  lowp vec4 tmpvar_83;
  tmpvar_83 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_83 * 2.5e-05));
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