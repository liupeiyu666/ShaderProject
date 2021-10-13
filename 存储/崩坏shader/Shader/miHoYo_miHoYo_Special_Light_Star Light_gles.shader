//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Light/Star Light" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 35698
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = -(((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0)).z);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = ((1.0/((
    (_ZBufferParams.z * texture2D (_CameraDepthTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w)).x)
   + _ZBufferParams.w))) - xlv_TEXCOORD2);
  if ((x_2 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_3));
  color_1.w = tmpvar_4.w;
  color_1.xyz = (tmpvar_4.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = -(((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0)).z);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = ((1.0/((
    (_ZBufferParams.z * texture2D (_CameraDepthTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w)).x)
   + _ZBufferParams.w))) - xlv_TEXCOORD2);
  if ((x_2 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_3));
  color_1.w = tmpvar_4.w;
  color_1.xyz = (tmpvar_4.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = -(((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0)).z);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform highp sampler2D _CameraDepthTexture;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = ((1.0/((
    (_ZBufferParams.z * texture2D (_CameraDepthTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w)).x)
   + _ZBufferParams.w))) - xlv_TEXCOORD2);
  if ((x_2 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_3));
  color_1.w = tmpvar_4.w;
  color_1.xyz = (tmpvar_4.xyz * _EmissionScaler);
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
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 78979
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = -(((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0)).z);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = ((1.0/((
    (_ZBufferParams.z * texture2D (_CameraDepthTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w)).x)
   + _ZBufferParams.w))) - xlv_TEXCOORD2);
  if ((x_2 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 rgb_4;
  rgb_4 = tmpvar_3.xyz;
  mediump float x_5;
  x_5 = (dot (rgb_4, vec3(0.22, 0.707, 0.071)) - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = -(((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0)).z);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = ((1.0/((
    (_ZBufferParams.z * texture2D (_CameraDepthTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w)).x)
   + _ZBufferParams.w))) - xlv_TEXCOORD2);
  if ((x_2 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 rgb_4;
  rgb_4 = tmpvar_3.xyz;
  mediump float x_5;
  x_5 = (dot (rgb_4, vec3(0.22, 0.707, 0.071)) - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)));
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = o_3;
  xlv_TEXCOORD2 = -(((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0)).z);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  highp float x_2;
  x_2 = ((1.0/((
    (_ZBufferParams.z * texture2D (_CameraDepthTexture, (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w)).x)
   + _ZBufferParams.w))) - xlv_TEXCOORD2);
  if ((x_2 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 rgb_4;
  rgb_4 = tmpvar_3.xyz;
  mediump float x_5;
  x_5 = (dot (rgb_4, vec3(0.22, 0.707, 0.071)) - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
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