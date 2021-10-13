//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "hidden/UI/Mask (Smooth)" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskTex ("Mask Texture", 2D) = "white" { }
_Color ("Tint Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 3)) = 1
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
  GpuProgramID 2114
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  tmpvar_4 = (_glesColor * _Color);
  tmpvar_7 = tmpvar_1.x;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 mask_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * xlv_COLOR) * _EmissionScaler);
  color_2.xyz = tmpvar_4.xyz;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD1);
  mask_1 = tmpvar_5;
  color_2.w = (tmpvar_4.w * mix (1.0, mask_1.w, xlv_TEXCOORD2));
  mediump float x_6;
  x_6 = (color_2.w - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  tmpvar_4 = (_glesColor * _Color);
  tmpvar_7 = tmpvar_1.x;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 mask_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * xlv_COLOR) * _EmissionScaler);
  color_2.xyz = tmpvar_4.xyz;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD1);
  mask_1 = tmpvar_5;
  color_2.w = (tmpvar_4.w * mix (1.0, mask_1.w, xlv_TEXCOORD2));
  mediump float x_6;
  x_6 = (color_2.w - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  tmpvar_4 = (_glesColor * _Color);
  tmpvar_7 = tmpvar_1.x;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump vec4 mask_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * xlv_COLOR) * _EmissionScaler);
  color_2.xyz = tmpvar_4.xyz;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD1);
  mask_1 = tmpvar_5;
  color_2.w = (tmpvar_4.w * mix (1.0, mask_1.w, xlv_TEXCOORD2));
  mediump float x_6;
  x_6 = (color_2.w - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_9.zw;
  tmpvar_8 = o_11;
  tmpvar_4 = (_glesColor * _Color);
  tmpvar_7 = tmpvar_1.x;
  gl_Position = tmpvar_9;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 mask_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * xlv_COLOR) * _EmissionScaler);
  color_2.xyz = tmpvar_4.xyz;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD1);
  mask_1 = tmpvar_5;
  color_2.w = (tmpvar_4.w * mix (1.0, mask_1.w, xlv_TEXCOORD2));
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_6 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  color_2.w = ((color_2.w * tmpvar_6.x) * ((tmpvar_6.y * tmpvar_6.z) * tmpvar_6.w));
  mediump float x_8;
  x_8 = (color_2.w - 0.01);
  if ((x_8 < 0.0)) {
    discard;
  };
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_9.zw;
  tmpvar_8 = o_11;
  tmpvar_4 = (_glesColor * _Color);
  tmpvar_7 = tmpvar_1.x;
  gl_Position = tmpvar_9;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 mask_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * xlv_COLOR) * _EmissionScaler);
  color_2.xyz = tmpvar_4.xyz;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD1);
  mask_1 = tmpvar_5;
  color_2.w = (tmpvar_4.w * mix (1.0, mask_1.w, xlv_TEXCOORD2));
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_6 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  color_2.w = ((color_2.w * tmpvar_6.x) * ((tmpvar_6.y * tmpvar_6.z) * tmpvar_6.w));
  mediump float x_8;
  x_8 = (color_2.w - 0.01);
  if ((x_8 < 0.0)) {
    discard;
  };
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesNormal;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump float tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_9.zw;
  tmpvar_8 = o_11;
  tmpvar_4 = (_glesColor * _Color);
  tmpvar_7 = tmpvar_1.x;
  gl_Position = tmpvar_9;
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump float _EmissionScaler;
uniform sampler2D _MainTex;
uniform sampler2D _MaskTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 mask_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_3 * xlv_COLOR) * _EmissionScaler);
  color_2.xyz = tmpvar_4.xyz;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MaskTex, xlv_TEXCOORD1);
  mask_1 = tmpvar_5;
  color_2.w = (tmpvar_4.w * mix (1.0, mask_1.w, xlv_TEXCOORD2));
  mediump vec4 tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_6 = (tmpvar_7 * (tmpvar_7 * (3.0 - 
    (2.0 * tmpvar_7)
  )));
  color_2.w = ((color_2.w * tmpvar_6.x) * ((tmpvar_6.y * tmpvar_6.z) * tmpvar_6.w));
  mediump float x_8;
  x_8 = (color_2.w - 0.01);
  if ((x_8 < 0.0)) {
    discard;
  };
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