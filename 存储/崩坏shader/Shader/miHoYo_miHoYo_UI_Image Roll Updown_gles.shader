//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Roll Updown" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_Speed ("Speed", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "DEFAULT"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 9512
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 + _TextureSampleAdd) * xlv_COLOR);
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 + _TextureSampleAdd) * xlv_COLOR);
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 + _TextureSampleAdd) * xlv_COLOR);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 + _TextureSampleAdd) * xlv_COLOR);
  mediump float x_3;
  x_3 = (tmpvar_2.w - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 + _TextureSampleAdd) * xlv_COLOR);
  mediump float x_3;
  x_3 = (tmpvar_2.w - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 + _TextureSampleAdd) * xlv_COLOR);
  mediump float x_3;
  x_3 = (tmpvar_2.w - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1.xyz = tmpvar_3.xyz;
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_1.w = (tmpvar_3.w * tmpvar_4);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1.xyz = tmpvar_3.xyz;
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_1.w = (tmpvar_3.w * tmpvar_4);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1.xyz = tmpvar_3.xyz;
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_1.w = (tmpvar_3.w * tmpvar_4);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1.xyz = tmpvar_3.xyz;
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_1.w = (tmpvar_3.w * tmpvar_4);
  mediump float x_7;
  x_7 = (color_1.w - 0.001);
  if ((x_7 < 0.0)) {
    discard;
  };
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1.xyz = tmpvar_3.xyz;
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_1.w = (tmpvar_3.w * tmpvar_4);
  mediump float x_7;
  x_7 = (color_1.w - 0.001);
  if ((x_7 < 0.0)) {
    discard;
  };
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp float _Speed;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = (_Time.y * _Speed);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + fract(tmpvar_4));
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TextureSampleAdd;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_2 + _TextureSampleAdd) * xlv_COLOR);
  color_1.xyz = tmpvar_3.xyz;
  highp float tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_5.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_6;
  tmpvar_6 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_5);
  tmpvar_4 = (tmpvar_6.x * tmpvar_6.y);
  color_1.w = (tmpvar_3.w * tmpvar_4);
  mediump float x_7;
  x_7 = (color_1.w - 0.001);
  if ((x_7 < 0.0)) {
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
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
}
}
}
}