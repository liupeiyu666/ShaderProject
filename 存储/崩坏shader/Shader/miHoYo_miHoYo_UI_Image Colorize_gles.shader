//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Colorize" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_RampTex ("Ramp Tex", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 57477
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp float grayscale_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2.w = tmpvar_4.w;
  mediump float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4.xyz, vec3(0.22, 0.707, 0.071));
  grayscale_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.5;
  tmpvar_6.x = grayscale_1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_RampTex, tmpvar_6).xyz;
  color_2.xyz = tmpvar_7;
  gl_FragData[0] = color_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp float grayscale_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2.w = tmpvar_4.w;
  mediump float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4.xyz, vec3(0.22, 0.707, 0.071));
  grayscale_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.5;
  tmpvar_6.x = grayscale_1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_RampTex, tmpvar_6).xyz;
  color_2.xyz = tmpvar_7;
  gl_FragData[0] = color_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp float grayscale_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  color_2.w = tmpvar_4.w;
  mediump float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4.xyz, vec3(0.22, 0.707, 0.071));
  grayscale_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.5;
  tmpvar_6.x = grayscale_1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_RampTex, tmpvar_6).xyz;
  color_2.xyz = tmpvar_7;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = tmpvar_1;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4 = o_7;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp float grayscale_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  mediump float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4.xyz, vec3(0.22, 0.707, 0.071));
  grayscale_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.5;
  tmpvar_6.x = grayscale_1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_RampTex, tmpvar_6).xyz;
  color_2.xyz = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  color_2.w = ((tmpvar_4.w * tmpvar_8.x) * ((tmpvar_8.y * tmpvar_8.z) * tmpvar_8.w));
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = tmpvar_1;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4 = o_7;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp float grayscale_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  mediump float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4.xyz, vec3(0.22, 0.707, 0.071));
  grayscale_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.5;
  tmpvar_6.x = grayscale_1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_RampTex, tmpvar_6).xyz;
  color_2.xyz = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  color_2.w = ((tmpvar_4.w * tmpvar_8.x) * ((tmpvar_8.y * tmpvar_8.z) * tmpvar_8.w));
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = tmpvar_1;
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_4 = o_7;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp float grayscale_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * xlv_COLOR);
  mediump float tmpvar_5;
  tmpvar_5 = dot (tmpvar_4.xyz, vec3(0.22, 0.707, 0.071));
  grayscale_1 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.y = 0.5;
  tmpvar_6.x = grayscale_1;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_RampTex, tmpvar_6).xyz;
  color_2.xyz = tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  color_2.w = ((tmpvar_4.w * tmpvar_8.x) * ((tmpvar_8.y * tmpvar_8.z) * tmpvar_8.w));
  gl_FragData[0] = color_2;
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
SubProgram "gles hw_tier00 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RECT_MASK" }
""
}
}
}
}
}