//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Multi-Layer 1" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Color0 ("Tint 0", Color) = (1,1,1,1)
_Tex0 ("Tex 0", 2D) = "white" { }
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
  GpuProgramID 32751
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform sampler2D _Tex0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _Color0);
  mediump float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = tmpvar_2;
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform sampler2D _Tex0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _Color0);
  mediump float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = tmpvar_2;
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform sampler2D _Tex0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _Color0);
  mediump float x_3;
  x_3 = (tmpvar_2.w - 0.01);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = tmpvar_1;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _Color0;
uniform sampler2D _Tex0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_3 = (tmpvar_4 * (tmpvar_4 * (3.0 - 
    (2.0 * tmpvar_4)
  )));
  color_1 = ((tmpvar_2 * _Color0) * ((tmpvar_3.x * tmpvar_3.y) * (tmpvar_3.z * tmpvar_3.w)));
  mediump float x_5;
  x_5 = (color_1.w - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = tmpvar_1;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _Color0;
uniform sampler2D _Tex0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_3 = (tmpvar_4 * (tmpvar_4 * (3.0 - 
    (2.0 * tmpvar_4)
  )));
  color_1 = ((tmpvar_2 * _Color0) * ((tmpvar_3.x * tmpvar_3.y) * (tmpvar_3.z * tmpvar_3.w)));
  mediump float x_5;
  x_5 = (color_1.w - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "RECT_MASK" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = tmpvar_1;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _Color0;
uniform sampler2D _Tex0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_3 = (tmpvar_4 * (tmpvar_4 * (3.0 - 
    (2.0 * tmpvar_4)
  )));
  color_1 = ((tmpvar_2 * _Color0) * ((tmpvar_3.x * tmpvar_3.y) * (tmpvar_3.z * tmpvar_3.w)));
  mediump float x_5;
  x_5 = (color_1.w - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
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