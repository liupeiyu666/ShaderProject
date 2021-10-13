//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Shadow/Blur Shadow Tex" {
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
  GpuProgramID 4591
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
  mediump vec3 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.047365, -0.047365) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3.xyz * 0.004956);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.018546, -0.018546) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4.xyz * 0.297577));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.005936, 0.005936) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5.xyz * 0.636881));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.032491, 0.032491) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6.xyz * 0.06043));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.0625, 0.0625) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7.xyz * 0.000155));
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = sum_2;
  gl_FragData[0] = tmpvar_8;
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
  mediump vec3 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.047365, -0.047365) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3.xyz * 0.004956);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.018546, -0.018546) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4.xyz * 0.297577));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.005936, 0.005936) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5.xyz * 0.636881));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.032491, 0.032491) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6.xyz * 0.06043));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.0625, 0.0625) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7.xyz * 0.000155));
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = sum_2;
  gl_FragData[0] = tmpvar_8;
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
  mediump vec3 sum_2;
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.047365, -0.047365) * _scaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (tmpvar_3.xyz * 0.004956);
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(-0.018546, -0.018546) * _scaler));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_4.xyz * 0.297577));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.005936, 0.005936) * _scaler));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_5.xyz * 0.636881));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.032491, 0.032491) * _scaler));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_6.xyz * 0.06043));
  _texcoord_1 = (xlv_TEXCOORD0 + (vec2(0.0625, 0.0625) * _scaler));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, _texcoord_1);
  sum_2 = (sum_2 + (tmpvar_7.xyz * 0.000155));
  mediump vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = sum_2;
  gl_FragData[0] = tmpvar_8;
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