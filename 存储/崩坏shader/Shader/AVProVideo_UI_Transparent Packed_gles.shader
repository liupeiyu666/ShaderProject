//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/UI/Transparent Packed" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_ChromaTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_VertScale ("Vertical Scale", Range(-1, 1)) = 1
[KeywordEnum(None, Top_Bottom, Left_Right)] AlphaPack ("Alpha Pack", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 8251
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_6.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_7;
  tmpvar_7 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_6);
  tmpvar_5 = (tmpvar_7.x * tmpvar_7.y);
  col_1.w = (col_1.w * tmpvar_5);
  lowp float x_8;
  x_8 = (col_1.w - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_6.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_7;
  tmpvar_7 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_6);
  tmpvar_5 = (tmpvar_7.x * tmpvar_7.y);
  col_1.w = (col_1.w * tmpvar_5);
  lowp float x_8;
  x_8 = (col_1.w - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_6.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_7;
  tmpvar_7 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_6);
  tmpvar_5 = (tmpvar_7.x * tmpvar_7.y);
  col_1.w = (col_1.w * tmpvar_5);
  lowp float x_8;
  x_8 = (col_1.w - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_6.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_7;
  tmpvar_7 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_6);
  tmpvar_5 = (tmpvar_7.x * tmpvar_7.y);
  col_1.w = (col_1.w * tmpvar_5);
  lowp float x_8;
  x_8 = (col_1.w - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_6.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_7;
  tmpvar_7 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_6);
  tmpvar_5 = (tmpvar_7.x * tmpvar_7.y);
  col_1.w = (col_1.w * tmpvar_5);
  lowp float x_8;
  x_8 = (col_1.w - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_6.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_7;
  tmpvar_7 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_6);
  tmpvar_5 = (tmpvar_7.x * tmpvar_7.y);
  col_1.w = (col_1.w * tmpvar_5);
  lowp float x_8;
  x_8 = (col_1.w - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_7.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_8;
  tmpvar_8 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_7);
  tmpvar_6 = (tmpvar_8.x * tmpvar_8.y);
  col_1.w = (col_1.w * tmpvar_6);
  lowp float x_9;
  x_9 = (col_1.w - 0.001);
  if ((x_9 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_7.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_8;
  tmpvar_8 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_7);
  tmpvar_6 = (tmpvar_8.x * tmpvar_8.y);
  col_1.w = (col_1.w * tmpvar_6);
  lowp float x_9;
  x_9 = (col_1.w - 0.001);
  if ((x_9 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_7.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_8;
  tmpvar_8 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_7);
  tmpvar_6 = (tmpvar_8.x * tmpvar_8.y);
  col_1.w = (col_1.w * tmpvar_6);
  lowp float x_9;
  x_9 = (col_1.w - 0.001);
  if ((x_9 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_7.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_8;
  tmpvar_8 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_7);
  tmpvar_6 = (tmpvar_8.x * tmpvar_8.y);
  col_1.w = (col_1.w * tmpvar_6);
  lowp float x_9;
  x_9 = (col_1.w - 0.001);
  if ((x_9 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_7.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_8;
  tmpvar_8 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_7);
  tmpvar_6 = (tmpvar_8.x * tmpvar_8.y);
  col_1.w = (col_1.w * tmpvar_6);
  lowp float x_9;
  x_9 = (col_1.w - 0.001);
  if ((x_9 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_7.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_8;
  tmpvar_8 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_7);
  tmpvar_6 = (tmpvar_8.x * tmpvar_8.y);
  col_1.w = (col_1.w * tmpvar_6);
  lowp float x_9;
  x_9 = (col_1.w - 0.001);
  if ((x_9 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8 = uv_7.xyxy;
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_11.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_12;
  tmpvar_12 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_11);
  tmpvar_10 = (tmpvar_12.x * tmpvar_12.y);
  col_1.w = (col_1.w * tmpvar_10);
  lowp float x_13;
  x_13 = (col_1.w - 0.001);
  if ((x_13 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.xzw = uv_7.xxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.y * 1.5);
  result_8.y = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.y);
  result_8.w = (result_8.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - result_8.yw);
    result_8.yw = result_8.wy;
  } else {
    result_8.yw = result_8.wy;
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1.xyz = tmpvar_4.xyz;
  highp vec2 uv_5;
  uv_5 = xlv_TEXCOORD0.zw;
  mediump float alpha_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv_5);
  mediump vec3 tmpvar_8;
  tmpvar_8 = tmpvar_7.xyz;
  alpha_6 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_6;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_10.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_11;
  tmpvar_11 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_10);
  tmpvar_9 = (tmpvar_11.x * tmpvar_11.y);
  col_1.w = (col_1.w * tmpvar_9);
  lowp float x_12;
  x_12 = (col_1.w - 0.001);
  if ((x_12 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0.zw;
  mediump float alpha_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, uv_6);
  mediump vec3 tmpvar_9;
  tmpvar_9 = tmpvar_8.xyz;
  mediump vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * ((tmpvar_9 * 
    ((tmpvar_9 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_7 = (((tmpvar_10.x + tmpvar_10.y) + tmpvar_10.z) / 3.0);
  col_1.w = alpha_7;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_12.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_13;
  tmpvar_13 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_12);
  tmpvar_11 = (tmpvar_13.x * tmpvar_13.y);
  col_1.w = (col_1.w * tmpvar_11);
  lowp float x_14;
  x_14 = (col_1.w - 0.001);
  if ((x_14 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4.xy = tmpvar_2;
  if ((_VertScale < 0.0)) {
    tmpvar_4.y = (1.0 - tmpvar_4.y);
  };
  highp vec2 uv_7;
  uv_7 = tmpvar_4.xy;
  highp vec4 result_8;
  result_8.yzw = uv_7.yxy;
  highp float tmpvar_9;
  tmpvar_9 = (_MainTex_TexelSize.x * 1.5);
  result_8.x = mix (tmpvar_9, (0.5 - tmpvar_9), uv_7.x);
  result_8.z = (result_8.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_8.yw = (1.0 - uv_7.yy);
  };
  tmpvar_4 = result_8;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform highp vec4 _ClipRect;
varying lowp vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0.xy;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_3.xyz;
  highp vec2 uv_10;
  uv_10 = xlv_TEXCOORD0.zw;
  mediump float alpha_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, uv_10);
  alpha_11 = ((tmpvar_12.x - 0.0625) * 1.164384);
  col_1.w = alpha_11;
  col_1 = (col_1 * xlv_COLOR);
  highp float tmpvar_13;
  highp vec2 tmpvar_14;
  tmpvar_14.x = float((_ClipRect.z >= xlv_TEXCOORD1.x));
  tmpvar_14.y = float((_ClipRect.w >= xlv_TEXCOORD1.y));
  highp vec2 tmpvar_15;
  tmpvar_15 = (vec2(greaterThanEqual (xlv_TEXCOORD1.xy, _ClipRect.xy)) * tmpvar_14);
  tmpvar_13 = (tmpvar_15.x * tmpvar_15.y);
  col_1.w = (col_1.w * tmpvar_13);
  lowp float x_16;
  x_16 = (col_1.w - 0.001);
  if ((x_16 < 0.0)) {
    discard;
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
}
}
}
}