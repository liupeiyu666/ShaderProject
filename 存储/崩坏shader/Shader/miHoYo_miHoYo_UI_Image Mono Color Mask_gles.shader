//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Mono Color Mask" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_MaskedTex ("Masked Texture", 2D) = "white" { }
_BackgroundTex ("Background Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_MaskedTexMonoColor ("Masked Texture Mono Color", Color) = (1,1,1,1)
_MaskedTexMonoIntensity ("Masked Texture Mono Intensity", Range(0, 1)) = 1
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
  GpuProgramID 60132
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp vec4 _BackgroundTex_ST;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _BackgroundTex_ST.xy) + _BackgroundTex_ST.zw);
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskedTex;
uniform sampler2D _BackgroundTex;
uniform mediump vec4 _MaskedTexMonoColor;
uniform mediump float _MaskedTexMonoIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 maskedColor_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_BackgroundTex, xlv_TEXCOORD2);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskedTex, xlv_TEXCOORD1);
  maskedColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = maskedColor_1.xyz;
  maskedColor_1.xyz = mix (tmpvar_5, _MaskedTexMonoColor, vec4(_MaskedTexMonoIntensity)).xyz;
  color_2.xyz = mix (color_2, maskedColor_1, maskedColor_1.wwww).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_6.w;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp vec4 _BackgroundTex_ST;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _BackgroundTex_ST.xy) + _BackgroundTex_ST.zw);
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskedTex;
uniform sampler2D _BackgroundTex;
uniform mediump vec4 _MaskedTexMonoColor;
uniform mediump float _MaskedTexMonoIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 maskedColor_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_BackgroundTex, xlv_TEXCOORD2);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskedTex, xlv_TEXCOORD1);
  maskedColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = maskedColor_1.xyz;
  maskedColor_1.xyz = mix (tmpvar_5, _MaskedTexMonoColor, vec4(_MaskedTexMonoIntensity)).xyz;
  color_2.xyz = mix (color_2, maskedColor_1, maskedColor_1.wwww).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_6.w;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp vec4 _BackgroundTex_ST;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _BackgroundTex_ST.xy) + _BackgroundTex_ST.zw);
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _MaskedTex;
uniform sampler2D _BackgroundTex;
uniform mediump vec4 _MaskedTexMonoColor;
uniform mediump float _MaskedTexMonoIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 maskedColor_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_BackgroundTex, xlv_TEXCOORD2);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskedTex, xlv_TEXCOORD1);
  maskedColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = maskedColor_1.xyz;
  maskedColor_1.xyz = mix (tmpvar_5, _MaskedTexMonoColor, vec4(_MaskedTexMonoIntensity)).xyz;
  color_2.xyz = mix (color_2, maskedColor_1, maskedColor_1.wwww).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_6.w;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp vec4 _BackgroundTex_ST;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _BackgroundTex_ST.xy) + _BackgroundTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_7 = o_10;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform sampler2D _MaskedTex;
uniform sampler2D _BackgroundTex;
uniform mediump vec4 _MaskedTexMonoColor;
uniform mediump float _MaskedTexMonoIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 maskedColor_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_BackgroundTex, xlv_TEXCOORD2);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskedTex, xlv_TEXCOORD1);
  maskedColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = maskedColor_1.xyz;
  maskedColor_1.xyz = mix (tmpvar_5, _MaskedTexMonoColor, vec4(_MaskedTexMonoIntensity)).xyz;
  color_2.xyz = mix (color_2, maskedColor_1, maskedColor_1.wwww).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_6.w;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_7 = (tmpvar_8 * (tmpvar_8 * (3.0 - 
    (2.0 * tmpvar_8)
  )));
  color_2.w = ((color_2.w * tmpvar_7.x) * ((tmpvar_7.y * tmpvar_7.z) * tmpvar_7.w));
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp vec4 _BackgroundTex_ST;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _BackgroundTex_ST.xy) + _BackgroundTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_7 = o_10;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform sampler2D _MaskedTex;
uniform sampler2D _BackgroundTex;
uniform mediump vec4 _MaskedTexMonoColor;
uniform mediump float _MaskedTexMonoIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 maskedColor_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_BackgroundTex, xlv_TEXCOORD2);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskedTex, xlv_TEXCOORD1);
  maskedColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = maskedColor_1.xyz;
  maskedColor_1.xyz = mix (tmpvar_5, _MaskedTexMonoColor, vec4(_MaskedTexMonoIntensity)).xyz;
  color_2.xyz = mix (color_2, maskedColor_1, maskedColor_1.wwww).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_6.w;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_7 = (tmpvar_8 * (tmpvar_8 * (3.0 - 
    (2.0 * tmpvar_8)
  )));
  color_2.w = ((color_2.w * tmpvar_7.x) * ((tmpvar_7.y * tmpvar_7.z) * tmpvar_7.w));
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform highp vec4 _BackgroundTex_ST;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = _glesVertex.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_4 = tmpvar_1;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = ((_glesMultiTexCoord1.xy * _BackgroundTex_ST.xy) + _BackgroundTex_ST.zw);
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_7 = o_10;
  tmpvar_3 = (_glesColor * _Color);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform sampler2D _MainTex;
uniform sampler2D _MaskedTex;
uniform sampler2D _BackgroundTex;
uniform mediump vec4 _MaskedTexMonoColor;
uniform mediump float _MaskedTexMonoIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 maskedColor_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_BackgroundTex, xlv_TEXCOORD2);
  color_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MaskedTex, xlv_TEXCOORD1);
  maskedColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = maskedColor_1.xyz;
  maskedColor_1.xyz = mix (tmpvar_5, _MaskedTexMonoColor, vec4(_MaskedTexMonoIntensity)).xyz;
  color_2.xyz = mix (color_2, maskedColor_1, maskedColor_1.wwww).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_6.w;
  mediump vec4 tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_7 = (tmpvar_8 * (tmpvar_8 * (3.0 - 
    (2.0 * tmpvar_8)
  )));
  color_2.w = ((color_2.w * tmpvar_7.x) * ((tmpvar_7.y * tmpvar_7.z) * tmpvar_7.w));
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