//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image NumberMatrix" {
Properties {
_MainTex ("Main Tex", 2D) = "white" { }
_TintColor ("Tint Color", Color) = (1,1,1,1)
_RandomTex ("Random Tex", 2D) = "white" { }
_FlowingTex ("Flowing Tex", 2D) = "white" { }
_NumberTex ("Number Tex", 2D) = "white" { }
_CellCount ("Cell Count (xy), Number Count", Vector) = (32,64,10,0)
_Speed ("Flowing Speed, Number Changing Speed", Vector) = (1,5,0,0)
_Intensity ("Global Intensity", Float) = 1
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
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent+1" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent+1" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 11488
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TintColor;
uniform sampler2D _RandomTex;
uniform highp vec4 _RandomTex_TexelSize;
uniform sampler2D _FlowingTex;
uniform highp vec4 _FlowingTex_TexelSize;
uniform sampler2D _NumberTex;
uniform highp vec4 _CellCount;
uniform highp vec4 _Speed;
uniform highp float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 ncolor_1;
  highp vec2 nc_2;
  highp float intens_3;
  highp float speed_4;
  highp vec2 cellc_5;
  mediump vec4 color_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0 * _CellCount.xy);
  cellc_5.x = tmpvar_7.x;
  highp vec2 P_8;
  P_8 = (tmpvar_7.xx * _RandomTex_TexelSize.x);
  lowp float tmpvar_9;
  tmpvar_9 = ((texture2D (_RandomTex, P_8).y * 3.0) + 1.0);
  speed_4 = tmpvar_9;
  cellc_5.y = (tmpvar_7.y + (fract(
    ((_Time.y * _FlowingTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _FlowingTex_TexelSize.x));
  highp vec2 P_10;
  P_10 = (cellc_5 * _FlowingTex_TexelSize.x);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FlowingTex, P_10).x;
  intens_3 = tmpvar_11;
  nc_2.y = cellc_5.y;
  nc_2.x = (tmpvar_7.x + (fract(
    ((_Time.y * _RandomTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _RandomTex_TexelSize.x));
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (nc_2 * _RandomTex_TexelSize.x);
  tmpvar_12 = texture2D (_RandomTex, P_13);
  highp vec2 tmpvar_14;
  tmpvar_14.y = 0.0;
  tmpvar_14.x = (floor((
    (tmpvar_12.x * _CellCount.z)
   + 0.5)) / _CellCount.z);
  highp vec2 tmpvar_15;
  tmpvar_15.x = fract((tmpvar_7.x / _CellCount.z));
  tmpvar_15.y = fract(cellc_5.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_14 + tmpvar_15);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NumberTex, tmpvar_16);
  ncolor_1 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = pow (intens_3, 3.0);
  color_6 = ((ncolor_1 * tmpvar_18) * (_Intensity * _TintColor));
  color_6.w = dot (color_6.xyz, vec3(0.22, 0.707, 0.071));
  gl_FragData[0] = color_6;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TintColor;
uniform sampler2D _RandomTex;
uniform highp vec4 _RandomTex_TexelSize;
uniform sampler2D _FlowingTex;
uniform highp vec4 _FlowingTex_TexelSize;
uniform sampler2D _NumberTex;
uniform highp vec4 _CellCount;
uniform highp vec4 _Speed;
uniform highp float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 ncolor_1;
  highp vec2 nc_2;
  highp float intens_3;
  highp float speed_4;
  highp vec2 cellc_5;
  mediump vec4 color_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0 * _CellCount.xy);
  cellc_5.x = tmpvar_7.x;
  highp vec2 P_8;
  P_8 = (tmpvar_7.xx * _RandomTex_TexelSize.x);
  lowp float tmpvar_9;
  tmpvar_9 = ((texture2D (_RandomTex, P_8).y * 3.0) + 1.0);
  speed_4 = tmpvar_9;
  cellc_5.y = (tmpvar_7.y + (fract(
    ((_Time.y * _FlowingTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _FlowingTex_TexelSize.x));
  highp vec2 P_10;
  P_10 = (cellc_5 * _FlowingTex_TexelSize.x);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FlowingTex, P_10).x;
  intens_3 = tmpvar_11;
  nc_2.y = cellc_5.y;
  nc_2.x = (tmpvar_7.x + (fract(
    ((_Time.y * _RandomTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _RandomTex_TexelSize.x));
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (nc_2 * _RandomTex_TexelSize.x);
  tmpvar_12 = texture2D (_RandomTex, P_13);
  highp vec2 tmpvar_14;
  tmpvar_14.y = 0.0;
  tmpvar_14.x = (floor((
    (tmpvar_12.x * _CellCount.z)
   + 0.5)) / _CellCount.z);
  highp vec2 tmpvar_15;
  tmpvar_15.x = fract((tmpvar_7.x / _CellCount.z));
  tmpvar_15.y = fract(cellc_5.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_14 + tmpvar_15);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NumberTex, tmpvar_16);
  ncolor_1 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = pow (intens_3, 3.0);
  color_6 = ((ncolor_1 * tmpvar_18) * (_Intensity * _TintColor));
  color_6.w = dot (color_6.xyz, vec3(0.22, 0.707, 0.071));
  gl_FragData[0] = color_6;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _TintColor;
uniform sampler2D _RandomTex;
uniform highp vec4 _RandomTex_TexelSize;
uniform sampler2D _FlowingTex;
uniform highp vec4 _FlowingTex_TexelSize;
uniform sampler2D _NumberTex;
uniform highp vec4 _CellCount;
uniform highp vec4 _Speed;
uniform highp float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 ncolor_1;
  highp vec2 nc_2;
  highp float intens_3;
  highp float speed_4;
  highp vec2 cellc_5;
  mediump vec4 color_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0 * _CellCount.xy);
  cellc_5.x = tmpvar_7.x;
  highp vec2 P_8;
  P_8 = (tmpvar_7.xx * _RandomTex_TexelSize.x);
  lowp float tmpvar_9;
  tmpvar_9 = ((texture2D (_RandomTex, P_8).y * 3.0) + 1.0);
  speed_4 = tmpvar_9;
  cellc_5.y = (tmpvar_7.y + (fract(
    ((_Time.y * _FlowingTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _FlowingTex_TexelSize.x));
  highp vec2 P_10;
  P_10 = (cellc_5 * _FlowingTex_TexelSize.x);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FlowingTex, P_10).x;
  intens_3 = tmpvar_11;
  nc_2.y = cellc_5.y;
  nc_2.x = (tmpvar_7.x + (fract(
    ((_Time.y * _RandomTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _RandomTex_TexelSize.x));
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (nc_2 * _RandomTex_TexelSize.x);
  tmpvar_12 = texture2D (_RandomTex, P_13);
  highp vec2 tmpvar_14;
  tmpvar_14.y = 0.0;
  tmpvar_14.x = (floor((
    (tmpvar_12.x * _CellCount.z)
   + 0.5)) / _CellCount.z);
  highp vec2 tmpvar_15;
  tmpvar_15.x = fract((tmpvar_7.x / _CellCount.z));
  tmpvar_15.y = fract(cellc_5.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_14 + tmpvar_15);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NumberTex, tmpvar_16);
  ncolor_1 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = pow (intens_3, 3.0);
  color_6 = ((ncolor_1 * tmpvar_18) * (_Intensity * _TintColor));
  color_6.w = dot (color_6.xyz, vec3(0.22, 0.707, 0.071));
  gl_FragData[0] = color_6;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = o_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform highp vec4 _TintColor;
uniform sampler2D _RandomTex;
uniform highp vec4 _RandomTex_TexelSize;
uniform sampler2D _FlowingTex;
uniform highp vec4 _FlowingTex_TexelSize;
uniform sampler2D _NumberTex;
uniform highp vec4 _CellCount;
uniform highp vec4 _Speed;
uniform highp float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 ncolor_1;
  highp vec2 nc_2;
  highp float intens_3;
  highp float speed_4;
  highp vec2 cellc_5;
  mediump vec4 color_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0 * _CellCount.xy);
  cellc_5.x = tmpvar_7.x;
  highp vec2 P_8;
  P_8 = (tmpvar_7.xx * _RandomTex_TexelSize.x);
  lowp float tmpvar_9;
  tmpvar_9 = ((texture2D (_RandomTex, P_8).y * 3.0) + 1.0);
  speed_4 = tmpvar_9;
  cellc_5.y = (tmpvar_7.y + (fract(
    ((_Time.y * _FlowingTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _FlowingTex_TexelSize.x));
  highp vec2 P_10;
  P_10 = (cellc_5 * _FlowingTex_TexelSize.x);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FlowingTex, P_10).x;
  intens_3 = tmpvar_11;
  nc_2.y = cellc_5.y;
  nc_2.x = (tmpvar_7.x + (fract(
    ((_Time.y * _RandomTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _RandomTex_TexelSize.x));
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (nc_2 * _RandomTex_TexelSize.x);
  tmpvar_12 = texture2D (_RandomTex, P_13);
  highp vec2 tmpvar_14;
  tmpvar_14.y = 0.0;
  tmpvar_14.x = (floor((
    (tmpvar_12.x * _CellCount.z)
   + 0.5)) / _CellCount.z);
  highp vec2 tmpvar_15;
  tmpvar_15.x = fract((tmpvar_7.x / _CellCount.z));
  tmpvar_15.y = fract(cellc_5.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_14 + tmpvar_15);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NumberTex, tmpvar_16);
  ncolor_1 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = pow (intens_3, 3.0);
  color_6 = ((ncolor_1 * tmpvar_18) * (_Intensity * _TintColor));
  color_6.w = dot (color_6.xyz, vec3(0.22, 0.707, 0.071));
  mediump vec4 tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_19 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  color_6 = (color_6 * ((tmpvar_19.x * tmpvar_19.y) * (tmpvar_19.z * tmpvar_19.w)));
  gl_FragData[0] = color_6;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = o_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform highp vec4 _TintColor;
uniform sampler2D _RandomTex;
uniform highp vec4 _RandomTex_TexelSize;
uniform sampler2D _FlowingTex;
uniform highp vec4 _FlowingTex_TexelSize;
uniform sampler2D _NumberTex;
uniform highp vec4 _CellCount;
uniform highp vec4 _Speed;
uniform highp float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 ncolor_1;
  highp vec2 nc_2;
  highp float intens_3;
  highp float speed_4;
  highp vec2 cellc_5;
  mediump vec4 color_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0 * _CellCount.xy);
  cellc_5.x = tmpvar_7.x;
  highp vec2 P_8;
  P_8 = (tmpvar_7.xx * _RandomTex_TexelSize.x);
  lowp float tmpvar_9;
  tmpvar_9 = ((texture2D (_RandomTex, P_8).y * 3.0) + 1.0);
  speed_4 = tmpvar_9;
  cellc_5.y = (tmpvar_7.y + (fract(
    ((_Time.y * _FlowingTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _FlowingTex_TexelSize.x));
  highp vec2 P_10;
  P_10 = (cellc_5 * _FlowingTex_TexelSize.x);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FlowingTex, P_10).x;
  intens_3 = tmpvar_11;
  nc_2.y = cellc_5.y;
  nc_2.x = (tmpvar_7.x + (fract(
    ((_Time.y * _RandomTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _RandomTex_TexelSize.x));
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (nc_2 * _RandomTex_TexelSize.x);
  tmpvar_12 = texture2D (_RandomTex, P_13);
  highp vec2 tmpvar_14;
  tmpvar_14.y = 0.0;
  tmpvar_14.x = (floor((
    (tmpvar_12.x * _CellCount.z)
   + 0.5)) / _CellCount.z);
  highp vec2 tmpvar_15;
  tmpvar_15.x = fract((tmpvar_7.x / _CellCount.z));
  tmpvar_15.y = fract(cellc_5.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_14 + tmpvar_15);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NumberTex, tmpvar_16);
  ncolor_1 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = pow (intens_3, 3.0);
  color_6 = ((ncolor_1 * tmpvar_18) * (_Intensity * _TintColor));
  color_6.w = dot (color_6.xyz, vec3(0.22, 0.707, 0.071));
  mediump vec4 tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_19 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  color_6 = (color_6 * ((tmpvar_19.x * tmpvar_19.y) * (tmpvar_19.z * tmpvar_19.w)));
  gl_FragData[0] = color_6;
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
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  tmpvar_1 = o_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD5 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform highp vec4 _TintColor;
uniform sampler2D _RandomTex;
uniform highp vec4 _RandomTex_TexelSize;
uniform sampler2D _FlowingTex;
uniform highp vec4 _FlowingTex_TexelSize;
uniform sampler2D _NumberTex;
uniform highp vec4 _CellCount;
uniform highp vec4 _Speed;
uniform highp float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec4 ncolor_1;
  highp vec2 nc_2;
  highp float intens_3;
  highp float speed_4;
  highp vec2 cellc_5;
  mediump vec4 color_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0 * _CellCount.xy);
  cellc_5.x = tmpvar_7.x;
  highp vec2 P_8;
  P_8 = (tmpvar_7.xx * _RandomTex_TexelSize.x);
  lowp float tmpvar_9;
  tmpvar_9 = ((texture2D (_RandomTex, P_8).y * 3.0) + 1.0);
  speed_4 = tmpvar_9;
  cellc_5.y = (tmpvar_7.y + (fract(
    ((_Time.y * _FlowingTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _FlowingTex_TexelSize.x));
  highp vec2 P_10;
  P_10 = (cellc_5 * _FlowingTex_TexelSize.x);
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_FlowingTex, P_10).x;
  intens_3 = tmpvar_11;
  nc_2.y = cellc_5.y;
  nc_2.x = (tmpvar_7.x + (fract(
    ((_Time.y * _RandomTex_TexelSize.x) * (speed_4 * _Speed.x))
  ) / _RandomTex_TexelSize.x));
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (nc_2 * _RandomTex_TexelSize.x);
  tmpvar_12 = texture2D (_RandomTex, P_13);
  highp vec2 tmpvar_14;
  tmpvar_14.y = 0.0;
  tmpvar_14.x = (floor((
    (tmpvar_12.x * _CellCount.z)
   + 0.5)) / _CellCount.z);
  highp vec2 tmpvar_15;
  tmpvar_15.x = fract((tmpvar_7.x / _CellCount.z));
  tmpvar_15.y = fract(cellc_5.y);
  highp vec2 tmpvar_16;
  tmpvar_16 = (tmpvar_14 + tmpvar_15);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NumberTex, tmpvar_16);
  ncolor_1 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = pow (intens_3, 3.0);
  color_6 = ((ncolor_1 * tmpvar_18) * (_Intensity * _TintColor));
  color_6.w = dot (color_6.xyz, vec3(0.22, 0.707, 0.071));
  mediump vec4 tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = clamp (((
    ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_19 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  color_6 = (color_6 * ((tmpvar_19.x * tmpvar_19.y) * (tmpvar_19.z * tmpvar_19.w)));
  gl_FragData[0] = color_6;
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