//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/UV Animation/Alpha Blended" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_Scaler ("Emmision Scaler", Range(0, 10)) = 1
_PolygonOffset ("Polygon Offset", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 41017
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump float _Scaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = (tmpvar_8.xyz * _Scaler);
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump float _Scaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = (tmpvar_8.xyz * _Scaler);
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump float _Scaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = (tmpvar_8.xyz * _Scaler);
  color_1.w = clamp (tmpvar_8.w, 0.0, 1.0);
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
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 117340
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = (_BloomFactor * mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor)).w);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = (_BloomFactor * mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor)).w);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + _nextFrameOffset);
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = (_BloomFactor * mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor)).w);
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
}