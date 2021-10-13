//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Multi-Layer 3" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Color0 ("Tint 0", Color) = (1,1,1,1)
_Color1 ("Tint 1", Color) = (1,1,1,1)
_Color2 ("Tint 2", Color) = (1,1,1,1)
_Tex0 ("Tex 0", 2D) = "white" { }
_Tex1 ("Tex 1", 2D) = "white" { }
_Tex2 ("Tex 2", 2D) = "white" { }
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
  GpuProgramID 46556
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_1;
  tmpvar_6 = tmpvar_2;
  tmpvar_7 = tmpvar_3.xz;
  tmpvar_4.x = float((tmpvar_5.x >= -0.1));
  tmpvar_4.y = float((tmpvar_6.x >= -0.1));
  tmpvar_4.z = float((tmpvar_7.x >= -0.1));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
uniform sampler2D _Tex2;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color2_2;
  mediump vec4 color1_3;
  mediump vec4 color0_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Color0);
  color0_4.xyz = tmpvar_6.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _Color1);
  color1_3.xyz = tmpvar_8.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Tex2, xlv_TEXCOORD2);
  mediump vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color2);
  color2_2.xyz = tmpvar_10.xyz;
  color0_4.w = (tmpvar_6.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_6.xyz * color0_4.w);
  color_1.w = (1.0 - color0_4.w);
  color1_3.w = (tmpvar_8.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_8.xyz, color1_3.www);
  color_1.w = (color_1.w * (1.0 - color1_3.w));
  color2_2.w = (tmpvar_10.w * xlv_COLOR.z);
  color_1.xyz = mix (color_1.xyz, tmpvar_10.xyz, color2_2.www);
  color_1.w = (color_1.w * (1.0 - color2_2.w));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_1;
  tmpvar_6 = tmpvar_2;
  tmpvar_7 = tmpvar_3.xz;
  tmpvar_4.x = float((tmpvar_5.x >= -0.1));
  tmpvar_4.y = float((tmpvar_6.x >= -0.1));
  tmpvar_4.z = float((tmpvar_7.x >= -0.1));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
uniform sampler2D _Tex2;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color2_2;
  mediump vec4 color1_3;
  mediump vec4 color0_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Color0);
  color0_4.xyz = tmpvar_6.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _Color1);
  color1_3.xyz = tmpvar_8.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Tex2, xlv_TEXCOORD2);
  mediump vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color2);
  color2_2.xyz = tmpvar_10.xyz;
  color0_4.w = (tmpvar_6.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_6.xyz * color0_4.w);
  color_1.w = (1.0 - color0_4.w);
  color1_3.w = (tmpvar_8.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_8.xyz, color1_3.www);
  color_1.w = (color_1.w * (1.0 - color1_3.w));
  color2_2.w = (tmpvar_10.w * xlv_COLOR.z);
  color_1.xyz = mix (color_1.xyz, tmpvar_10.xyz, color2_2.www);
  color_1.w = (color_1.w * (1.0 - color2_2.w));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_5 = tmpvar_1;
  tmpvar_6 = tmpvar_2;
  tmpvar_7 = tmpvar_3.xz;
  tmpvar_4.x = float((tmpvar_5.x >= -0.1));
  tmpvar_4.y = float((tmpvar_6.x >= -0.1));
  tmpvar_4.z = float((tmpvar_7.x >= -0.1));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
uniform sampler2D _Tex2;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color2_2;
  mediump vec4 color1_3;
  mediump vec4 color0_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Color0);
  color0_4.xyz = tmpvar_6.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _Color1);
  color1_3.xyz = tmpvar_8.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Tex2, xlv_TEXCOORD2);
  mediump vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color2);
  color2_2.xyz = tmpvar_10.xyz;
  color0_4.w = (tmpvar_6.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_6.xyz * color0_4.w);
  color_1.w = (1.0 - color0_4.w);
  color1_3.w = (tmpvar_8.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_8.xyz, color1_3.www);
  color_1.w = (color_1.w * (1.0 - color1_3.w));
  color2_2.w = (tmpvar_10.w * xlv_COLOR.z);
  color_1.xyz = mix (color_1.xyz, tmpvar_10.xyz, color2_2.www);
  color_1.w = (color_1.w * (1.0 - color2_2.w));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = tmpvar_1;
  tmpvar_6 = tmpvar_2;
  tmpvar_7 = tmpvar_3.xz;
  tmpvar_4.x = float((tmpvar_5.x >= -0.1));
  tmpvar_4.y = float((tmpvar_6.x >= -0.1));
  tmpvar_4.z = float((tmpvar_7.x >= -0.1));
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_9.zw;
  tmpvar_8 = o_11;
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
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
uniform sampler2D _Tex2;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color2_2;
  mediump vec4 color1_3;
  mediump vec4 color0_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Color0);
  color0_4.xyz = tmpvar_6.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _Color1);
  color1_3.xyz = tmpvar_8.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Tex2, xlv_TEXCOORD2);
  mediump vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color2);
  color2_2.xyz = tmpvar_10.xyz;
  color0_4.w = (tmpvar_6.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_6.xyz * color0_4.w);
  color_1.w = (1.0 - color0_4.w);
  color1_3.w = (tmpvar_8.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_8.xyz, color1_3.www);
  color_1.w = (color_1.w * (1.0 - color1_3.w));
  color2_2.w = (tmpvar_10.w * xlv_COLOR.z);
  color_1.xyz = mix (color_1.xyz, tmpvar_10.xyz, color2_2.www);
  color_1.w = (color_1.w * (1.0 - color2_2.w));
  color_1.w = (1.0 - color_1.w);
  mediump vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  color_1 = (color_1 * ((tmpvar_11.x * tmpvar_11.y) * (tmpvar_11.z * tmpvar_11.w)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = tmpvar_1;
  tmpvar_6 = tmpvar_2;
  tmpvar_7 = tmpvar_3.xz;
  tmpvar_4.x = float((tmpvar_5.x >= -0.1));
  tmpvar_4.y = float((tmpvar_6.x >= -0.1));
  tmpvar_4.z = float((tmpvar_7.x >= -0.1));
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_9.zw;
  tmpvar_8 = o_11;
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
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
uniform sampler2D _Tex2;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color2_2;
  mediump vec4 color1_3;
  mediump vec4 color0_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Color0);
  color0_4.xyz = tmpvar_6.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _Color1);
  color1_3.xyz = tmpvar_8.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Tex2, xlv_TEXCOORD2);
  mediump vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color2);
  color2_2.xyz = tmpvar_10.xyz;
  color0_4.w = (tmpvar_6.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_6.xyz * color0_4.w);
  color_1.w = (1.0 - color0_4.w);
  color1_3.w = (tmpvar_8.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_8.xyz, color1_3.www);
  color_1.w = (color_1.w * (1.0 - color1_3.w));
  color2_2.w = (tmpvar_10.w * xlv_COLOR.z);
  color_1.xyz = mix (color_1.xyz, tmpvar_10.xyz, color2_2.www);
  color_1.w = (color_1.w * (1.0 - color2_2.w));
  color_1.w = (1.0 - color_1.w);
  mediump vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  color_1 = (color_1 * ((tmpvar_11.x * tmpvar_11.y) * (tmpvar_11.z * tmpvar_11.w)));
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  mediump vec3 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  tmpvar_5 = tmpvar_1;
  tmpvar_6 = tmpvar_2;
  tmpvar_7 = tmpvar_3.xz;
  tmpvar_4.x = float((tmpvar_5.x >= -0.1));
  tmpvar_4.y = float((tmpvar_6.x >= -0.1));
  tmpvar_4.z = float((tmpvar_7.x >= -0.1));
  highp vec4 o_11;
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_13;
  tmpvar_13.x = tmpvar_12.x;
  tmpvar_13.y = (tmpvar_12.y * _ProjectionParams.x);
  o_11.xy = (tmpvar_13 + tmpvar_12.w);
  o_11.zw = tmpvar_9.zw;
  tmpvar_8 = o_11;
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
uniform mediump vec4 _Color0;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color2;
uniform sampler2D _Tex0;
uniform sampler2D _Tex1;
uniform sampler2D _Tex2;
varying mediump vec3 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 color2_2;
  mediump vec4 color1_3;
  mediump vec4 color0_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Tex0, xlv_TEXCOORD0);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _Color0);
  color0_4.xyz = tmpvar_6.xyz;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD1);
  mediump vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _Color1);
  color1_3.xyz = tmpvar_8.xyz;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_Tex2, xlv_TEXCOORD2);
  mediump vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _Color2);
  color2_2.xyz = tmpvar_10.xyz;
  color0_4.w = (tmpvar_6.w * xlv_COLOR.x);
  color_1.xyz = (tmpvar_6.xyz * color0_4.w);
  color_1.w = (1.0 - color0_4.w);
  color1_3.w = (tmpvar_8.w * xlv_COLOR.y);
  color_1.xyz = mix (color_1.xyz, tmpvar_8.xyz, color1_3.www);
  color_1.w = (color_1.w * (1.0 - color1_3.w));
  color2_2.w = (tmpvar_10.w * xlv_COLOR.z);
  color_1.xyz = mix (color_1.xyz, tmpvar_10.xyz, color2_2.www);
  color_1.w = (color_1.w * (1.0 - color2_2.w));
  color_1.w = (1.0 - color_1.w);
  mediump vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  color_1 = (color_1 * ((tmpvar_11.x * tmpvar_11.y) * (tmpvar_11.z * tmpvar_11.w)));
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