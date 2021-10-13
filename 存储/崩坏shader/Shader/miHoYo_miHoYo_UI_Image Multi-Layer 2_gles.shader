//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Multi-Layer 2" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Color0 ("Tint 0", Color) = (1,1,1,1)
_Color1 ("Tint 1", Color) = (1,1,1,1)
_Tex0 ("Tex 0", 2D) = "white" { }
_Tex1 ("Tex 1", 2D) = "white" { }
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
  GpuProgramID 55268
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_3.x = float((tmpvar_4.x >= -0.1));
  tmpvar_3.y = float((tmpvar_5.x >= -0.1));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color1_2;
  mediump vec4 color0_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * _Color0);
  color0_3.xyz = tmpvar_5.xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _Color1);
  color1_2.xyz = tmpvar_7.xyz;
  color0_3.w = (tmpvar_5.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_5.xyz * color0_3.w);
  color_1.w = (1.0 - color0_3.w);
  color1_2.w = (tmpvar_7.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_7.xyz, color1_2.www);
  color_1.w = (color_1.w * (1.0 - color1_2.w));
  color_1.w = (1.0 - color_1.w);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_3.x = float((tmpvar_4.x >= -0.1));
  tmpvar_3.y = float((tmpvar_5.x >= -0.1));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color1_2;
  mediump vec4 color0_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * _Color0);
  color0_3.xyz = tmpvar_5.xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _Color1);
  color1_2.xyz = tmpvar_7.xyz;
  color0_3.w = (tmpvar_5.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_5.xyz * color0_3.w);
  color_1.w = (1.0 - color0_3.w);
  color1_2.w = (tmpvar_7.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_7.xyz, color1_2.www);
  color_1.w = (color_1.w * (1.0 - color1_2.w));
  color_1.w = (1.0 - color_1.w);
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_3.x = float((tmpvar_4.x >= -0.1));
  tmpvar_3.y = float((tmpvar_5.x >= -0.1));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color1_2;
  mediump vec4 color0_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * _Color0);
  color0_3.xyz = tmpvar_5.xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _Color1);
  color1_2.xyz = tmpvar_7.xyz;
  color0_3.w = (tmpvar_5.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_5.xyz * color0_3.w);
  color_1.w = (1.0 - color0_3.w);
  color1_2.w = (tmpvar_7.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_7.xyz, color1_2.www);
  color_1.w = (color_1.w * (1.0 - color1_2.w));
  color_1.w = (1.0 - color_1.w);
  gl_FragData[0] = color_1;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_3.x = float((tmpvar_4.x >= -0.1));
  tmpvar_3.y = float((tmpvar_5.x >= -0.1));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = o_9;
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color1_2;
  mediump vec4 color0_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * _Color0);
  color0_3.xyz = tmpvar_5.xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _Color1);
  color1_2.xyz = tmpvar_7.xyz;
  color0_3.w = (tmpvar_5.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_5.xyz * color0_3.w);
  color_1.w = (1.0 - color0_3.w);
  color1_2.w = (tmpvar_7.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_7.xyz, color1_2.www);
  color_1.w = (color_1.w * (1.0 - color1_2.w));
  color_1.w = (1.0 - color_1.w);
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  color_1 = (color_1 * ((tmpvar_8.x * tmpvar_8.y) * (tmpvar_8.z * tmpvar_8.w)));
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_3.x = float((tmpvar_4.x >= -0.1));
  tmpvar_3.y = float((tmpvar_5.x >= -0.1));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = o_9;
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color1_2;
  mediump vec4 color0_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * _Color0);
  color0_3.xyz = tmpvar_5.xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _Color1);
  color1_2.xyz = tmpvar_7.xyz;
  color0_3.w = (tmpvar_5.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_5.xyz * color0_3.w);
  color_1.w = (1.0 - color0_3.w);
  color1_2.w = (tmpvar_7.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_7.xyz, color1_2.www);
  color_1.w = (color_1.w * (1.0 - color1_2.w));
  color_1.w = (1.0 - color_1.w);
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  color_1 = (color_1 * ((tmpvar_8.x * tmpvar_8.y) * (tmpvar_8.z * tmpvar_8.w)));
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_3.x = float((tmpvar_4.x >= -0.1));
  tmpvar_3.y = float((tmpvar_5.x >= -0.1));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  tmpvar_6 = o_9;
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
varying mediump vec2 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color1_2;
  mediump vec4 color0_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * _Color0);
  color0_3.xyz = tmpvar_5.xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _Color1);
  color1_2.xyz = tmpvar_7.xyz;
  color0_3.w = (tmpvar_5.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_5.xyz * color0_3.w);
  color_1.w = (1.0 - color0_3.w);
  color1_2.w = (tmpvar_7.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_7.xyz, color1_2.www);
  color_1.w = (color_1.w * (1.0 - color1_2.w));
  color_1.w = (1.0 - color_1.w);
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  color_1 = (color_1 * ((tmpvar_8.x * tmpvar_8.y) * (tmpvar_8.z * tmpvar_8.w)));
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