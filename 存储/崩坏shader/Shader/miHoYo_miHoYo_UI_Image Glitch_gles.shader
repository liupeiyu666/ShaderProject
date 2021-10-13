//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Glitch" {
Properties {
_MainColor ("MainColor", Color) = (0,0,0,0)
_MainTex ("_MainTex", 2D) = "white" { }
_MainIndensity ("MainIndensity", Float) = 0
_MainOpacity ("MainOpacity", Range(0, 1)) = 0
_BgOpacity ("BgOpacity", Range(-2, 1)) = 0
_BackGroundColor ("BackGroundColor", Color) = (0,0,0,0)
_InsideTexture ("InsideTexture", 2D) = "white" { }
_insideTexR ("InsideTextureR", Float) = 1
_insideTexG ("InsideTextureG", Float) = 1
_insideTexB ("InsideTextureB", Float) = 1
_InsideColor ("InsideColor", Color) = (0,0,0,0)
_InsideIndensity ("InsideIndensity", Float) = 0
_InsideSpeed ("InsideSpeed", Vector) = (0,0,0,0)
_OffsetCtTexture ("OffsetCtTexture", 2D) = "white" { }
_OffsetIndensity ("OffsetIndensity", Range(-0.2, 1)) = 1
_OffsetTiling ("OffsetTiling", Vector) = (0,0,0,0)
_OffsetCtSpeed ("OffsetCtSpeed", Vector) = (0,0,0,0)
_NoiseTexture ("NoiseTexture", 2D) = "white" { }
_NoiseTilling ("NoiseTilling", Vector) = (1,1,0,0)
_BgMainTex ("BgMainTex", 2D) = "white" { }
_BgMainTexColor ("BgMainTexColor", Color) = (0.1260235,0.4452659,0.4528302,0)
_BgMainTexIntensity ("BgMainTexIntensity", Float) = 1
_BgMainTexSpeed ("BgMainTexSpeed", Vector) = (0,0.02,0,0)
_BgMainTexMaskSpeed ("BgMainTexMaskSpeed", Vector) = (0.01,0.61,0,0)
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
_RMCCRect ("Rect Color Change Mask Rect", Vector) = (0,0,0,0)
_RMCCTransitWidth ("Rect Color Change Mask Transit Width", Vector) = (0,0,0,0)
_ColorChangeIntensity ("ColorChangeIntensity", Range(0, 10)) = 0
_ColorChangePow ("ColorChangePow", Range(0, 10)) = 0
_ColorMask ("Color Mask", Float) = 15
[Enum(UnityEngine.Rendering.BlendMode)] _DstFactor ("DstFactor", Float) = 10
}
SubShader {
 LOD 100
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  GpuProgramID 53463
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp float _MainOpacity;
uniform highp float _BgOpacity;
uniform sampler2D _MainTex;
uniform highp vec4 _BackGroundColor;
uniform highp float _MainIndensity;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 OutColor_1;
  mediump float OutAlpha_2;
  highp vec4 mainTex2_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex2_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_MainOpacity + (_BgOpacity * vec4((1.0 - mainTex2_3.w)))).x;
  OutAlpha_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (((mainTex2_3 * _MainIndensity) * _MainColor) + _BackGroundColor).xyz;
  OutColor_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.xyz = OutColor_1;
  tmpvar_7.w = OutAlpha_2;
  gl_FragData[0] = tmpvar_7;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp float _MainOpacity;
uniform highp float _BgOpacity;
uniform sampler2D _MainTex;
uniform highp vec4 _BackGroundColor;
uniform highp float _MainIndensity;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 OutColor_1;
  mediump float OutAlpha_2;
  highp vec4 mainTex2_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex2_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_MainOpacity + (_BgOpacity * vec4((1.0 - mainTex2_3.w)))).x;
  OutAlpha_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (((mainTex2_3 * _MainIndensity) * _MainColor) + _BackGroundColor).xyz;
  OutColor_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.xyz = OutColor_1;
  tmpvar_7.w = OutAlpha_2;
  gl_FragData[0] = tmpvar_7;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp float _MainOpacity;
uniform highp float _BgOpacity;
uniform sampler2D _MainTex;
uniform highp vec4 _BackGroundColor;
uniform highp float _MainIndensity;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 OutColor_1;
  mediump float OutAlpha_2;
  highp vec4 mainTex2_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mainTex2_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_MainOpacity + (_BgOpacity * vec4((1.0 - mainTex2_3.w)))).x;
  OutAlpha_2 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = (((mainTex2_3 * _MainIndensity) * _MainColor) + _BackGroundColor).xyz;
  OutColor_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.xyz = OutColor_1;
  tmpvar_7.w = OutAlpha_2;
  gl_FragData[0] = tmpvar_7;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
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
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _RMCCRect;
uniform mediump vec4 _RMCCTransitWidth;
uniform highp float _MainOpacity;
uniform highp float _BgOpacity;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTexture;
uniform highp vec2 _InsideSpeed;
uniform highp vec2 _NoiseTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _OffsetCtTexture;
uniform highp vec2 _OffsetCtSpeed;
uniform highp vec2 _OffsetTiling;
uniform sampler2D _InsideTexture;
uniform highp float _insideTexR;
uniform highp float _insideTexG;
uniform highp float _insideTexB;
uniform highp float _InsideIndensity;
uniform highp vec4 _BackGroundColor;
uniform highp vec4 _InsideColor;
uniform highp float _MainIndensity;
uniform highp vec4 _MainColor;
uniform sampler2D _BgMainTex;
uniform highp vec4 _BgMainTex_ST;
uniform highp vec2 _BgMainTexMaskSpeed;
uniform highp vec2 _BgMainTexSpeed;
uniform highp vec4 _BgMainTexColor;
uniform highp float _BgMainTexIntensity;
uniform highp float _ColorChangeIntensity;
uniform highp float _ColorChangePow;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 OutColor_1;
  mediump float OutAlpha_2;
  highp float backGroundTexColor_3;
  highp vec4 mainTex2_4;
  highp vec4 noiseTex_5;
  mediump vec2 rmuv_6;
  rmuv_6 = (xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w);
  mediump float tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    (rmuv_6.xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  tmpvar_7 = ((tmpvar_8.x * tmpvar_8.y) * (tmpvar_8.z * tmpvar_8.w));
  mediump float tmpvar_10;
  mediump vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = clamp (((
    (rmuv_6.xyxy - _RMCCRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMCCTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  tmpvar_10 = ((tmpvar_11.x * tmpvar_11.y) * (tmpvar_11.z * tmpvar_11.w));
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _InsideSpeed) + (xlv_TEXCOORD0.xy * _NoiseTilling));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTexture, tmpvar_13);
  noiseTex_5 = tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((_Time.y * _OffsetCtSpeed) + (xlv_TEXCOORD0.xy * (_OffsetTiling * vec2(0.5, 0.5))));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_OffsetCtTexture, tmpvar_15);
  highp float tmpvar_17;
  tmpvar_17 = ((noiseTex_5.x * tmpvar_7) * (_OffsetIndensity * tmpvar_16.x));
  highp vec2 tmpvar_18;
  tmpvar_18.x = (xlv_TEXCOORD0.x + tmpvar_17);
  tmpvar_18.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, tmpvar_18);
  mainTex2_4 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_InsideTexture, tmpvar_13);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_InsideTexture, tmpvar_13);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_InsideTexture, tmpvar_13);
  highp vec4 tmpvar_23;
  tmpvar_23 = ((mainTex2_4.z * (
    (vec4((((tmpvar_20.x * _insideTexR) + (tmpvar_21.y * _insideTexG)) + (tmpvar_22.z * _insideTexB))) * tmpvar_17)
   * 
    (1.0 - noiseTex_5.x)
  )) * (_InsideIndensity * 50.0));
  highp vec2 tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (xlv_TEXCOORD0.xy * _BgMainTex_ST.xy);
  tmpvar_24 = ((_Time.y * _BgMainTexSpeed) + (tmpvar_25 + _BgMainTex_ST.zw));
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _BgMainTexMaskSpeed) + (tmpvar_25 + _BgMainTex_ST.zw));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (float((
    (texture2D (_BgMainTex, tmpvar_26).x * texture2D (_BgMainTex, tmpvar_24).x)
   >= 0.1)), 0.0, 1.0);
  backGroundTexColor_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (_MainOpacity + (_BgOpacity * (
    (1.0 - mainTex2_4.w)
   * 
    (1.0 - tmpvar_23)
  ))).x;
  OutAlpha_2 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    ((mainTex2_4 * _MainIndensity) * _MainColor)
   + 
    ((_InsideColor * tmpvar_23) * tmpvar_7)
  ) + (
    (((backGroundTexColor_3 * _BgMainTexIntensity) * _BgMainTexColor) * tmpvar_7)
   * OutAlpha_2)) + _BackGroundColor).xyz;
  OutColor_1 = tmpvar_29;
  highp float tmpvar_30;
  mediump float x_31;
  x_31 = (1.0 - rmuv_6.y);
  tmpvar_30 = pow (x_31, _ColorChangePow);
  OutColor_1 = (((OutColor_1 * tmpvar_10) * (tmpvar_30 * _ColorChangeIntensity)) + (OutColor_1 * (1.0 - tmpvar_10)));
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = OutColor_1;
  tmpvar_32.w = OutAlpha_2;
  gl_FragData[0] = tmpvar_32;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
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
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _RMCCRect;
uniform mediump vec4 _RMCCTransitWidth;
uniform highp float _MainOpacity;
uniform highp float _BgOpacity;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTexture;
uniform highp vec2 _InsideSpeed;
uniform highp vec2 _NoiseTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _OffsetCtTexture;
uniform highp vec2 _OffsetCtSpeed;
uniform highp vec2 _OffsetTiling;
uniform sampler2D _InsideTexture;
uniform highp float _insideTexR;
uniform highp float _insideTexG;
uniform highp float _insideTexB;
uniform highp float _InsideIndensity;
uniform highp vec4 _BackGroundColor;
uniform highp vec4 _InsideColor;
uniform highp float _MainIndensity;
uniform highp vec4 _MainColor;
uniform sampler2D _BgMainTex;
uniform highp vec4 _BgMainTex_ST;
uniform highp vec2 _BgMainTexMaskSpeed;
uniform highp vec2 _BgMainTexSpeed;
uniform highp vec4 _BgMainTexColor;
uniform highp float _BgMainTexIntensity;
uniform highp float _ColorChangeIntensity;
uniform highp float _ColorChangePow;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 OutColor_1;
  mediump float OutAlpha_2;
  highp float backGroundTexColor_3;
  highp vec4 mainTex2_4;
  highp vec4 noiseTex_5;
  mediump vec2 rmuv_6;
  rmuv_6 = (xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w);
  mediump float tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    (rmuv_6.xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  tmpvar_7 = ((tmpvar_8.x * tmpvar_8.y) * (tmpvar_8.z * tmpvar_8.w));
  mediump float tmpvar_10;
  mediump vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = clamp (((
    (rmuv_6.xyxy - _RMCCRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMCCTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  tmpvar_10 = ((tmpvar_11.x * tmpvar_11.y) * (tmpvar_11.z * tmpvar_11.w));
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _InsideSpeed) + (xlv_TEXCOORD0.xy * _NoiseTilling));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTexture, tmpvar_13);
  noiseTex_5 = tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((_Time.y * _OffsetCtSpeed) + (xlv_TEXCOORD0.xy * (_OffsetTiling * vec2(0.5, 0.5))));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_OffsetCtTexture, tmpvar_15);
  highp float tmpvar_17;
  tmpvar_17 = ((noiseTex_5.x * tmpvar_7) * (_OffsetIndensity * tmpvar_16.x));
  highp vec2 tmpvar_18;
  tmpvar_18.x = (xlv_TEXCOORD0.x + tmpvar_17);
  tmpvar_18.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, tmpvar_18);
  mainTex2_4 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_InsideTexture, tmpvar_13);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_InsideTexture, tmpvar_13);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_InsideTexture, tmpvar_13);
  highp vec4 tmpvar_23;
  tmpvar_23 = ((mainTex2_4.z * (
    (vec4((((tmpvar_20.x * _insideTexR) + (tmpvar_21.y * _insideTexG)) + (tmpvar_22.z * _insideTexB))) * tmpvar_17)
   * 
    (1.0 - noiseTex_5.x)
  )) * (_InsideIndensity * 50.0));
  highp vec2 tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (xlv_TEXCOORD0.xy * _BgMainTex_ST.xy);
  tmpvar_24 = ((_Time.y * _BgMainTexSpeed) + (tmpvar_25 + _BgMainTex_ST.zw));
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _BgMainTexMaskSpeed) + (tmpvar_25 + _BgMainTex_ST.zw));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (float((
    (texture2D (_BgMainTex, tmpvar_26).x * texture2D (_BgMainTex, tmpvar_24).x)
   >= 0.1)), 0.0, 1.0);
  backGroundTexColor_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (_MainOpacity + (_BgOpacity * (
    (1.0 - mainTex2_4.w)
   * 
    (1.0 - tmpvar_23)
  ))).x;
  OutAlpha_2 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    ((mainTex2_4 * _MainIndensity) * _MainColor)
   + 
    ((_InsideColor * tmpvar_23) * tmpvar_7)
  ) + (
    (((backGroundTexColor_3 * _BgMainTexIntensity) * _BgMainTexColor) * tmpvar_7)
   * OutAlpha_2)) + _BackGroundColor).xyz;
  OutColor_1 = tmpvar_29;
  highp float tmpvar_30;
  mediump float x_31;
  x_31 = (1.0 - rmuv_6.y);
  tmpvar_30 = pow (x_31, _ColorChangePow);
  OutColor_1 = (((OutColor_1 * tmpvar_10) * (tmpvar_30 * _ColorChangeIntensity)) + (OutColor_1 * (1.0 - tmpvar_10)));
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = OutColor_1;
  tmpvar_32.w = OutAlpha_2;
  gl_FragData[0] = tmpvar_32;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
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
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD4 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _RMCCRect;
uniform mediump vec4 _RMCCTransitWidth;
uniform highp float _MainOpacity;
uniform highp float _BgOpacity;
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTexture;
uniform highp vec2 _InsideSpeed;
uniform highp vec2 _NoiseTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _OffsetCtTexture;
uniform highp vec2 _OffsetCtSpeed;
uniform highp vec2 _OffsetTiling;
uniform sampler2D _InsideTexture;
uniform highp float _insideTexR;
uniform highp float _insideTexG;
uniform highp float _insideTexB;
uniform highp float _InsideIndensity;
uniform highp vec4 _BackGroundColor;
uniform highp vec4 _InsideColor;
uniform highp float _MainIndensity;
uniform highp vec4 _MainColor;
uniform sampler2D _BgMainTex;
uniform highp vec4 _BgMainTex_ST;
uniform highp vec2 _BgMainTexMaskSpeed;
uniform highp vec2 _BgMainTexSpeed;
uniform highp vec4 _BgMainTexColor;
uniform highp float _BgMainTexIntensity;
uniform highp float _ColorChangeIntensity;
uniform highp float _ColorChangePow;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 OutColor_1;
  mediump float OutAlpha_2;
  highp float backGroundTexColor_3;
  highp vec4 mainTex2_4;
  highp vec4 noiseTex_5;
  mediump vec2 rmuv_6;
  rmuv_6 = (xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w);
  mediump float tmpvar_7;
  mediump vec4 tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = clamp (((
    (rmuv_6.xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_8 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  tmpvar_7 = ((tmpvar_8.x * tmpvar_8.y) * (tmpvar_8.z * tmpvar_8.w));
  mediump float tmpvar_10;
  mediump vec4 tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = clamp (((
    (rmuv_6.xyxy - _RMCCRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMCCTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  tmpvar_10 = ((tmpvar_11.x * tmpvar_11.y) * (tmpvar_11.z * tmpvar_11.w));
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _InsideSpeed) + (xlv_TEXCOORD0.xy * _NoiseTilling));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_NoiseTexture, tmpvar_13);
  noiseTex_5 = tmpvar_14;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((_Time.y * _OffsetCtSpeed) + (xlv_TEXCOORD0.xy * (_OffsetTiling * vec2(0.5, 0.5))));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_OffsetCtTexture, tmpvar_15);
  highp float tmpvar_17;
  tmpvar_17 = ((noiseTex_5.x * tmpvar_7) * (_OffsetIndensity * tmpvar_16.x));
  highp vec2 tmpvar_18;
  tmpvar_18.x = (xlv_TEXCOORD0.x + tmpvar_17);
  tmpvar_18.y = xlv_TEXCOORD0.y;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, tmpvar_18);
  mainTex2_4 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_InsideTexture, tmpvar_13);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_InsideTexture, tmpvar_13);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_InsideTexture, tmpvar_13);
  highp vec4 tmpvar_23;
  tmpvar_23 = ((mainTex2_4.z * (
    (vec4((((tmpvar_20.x * _insideTexR) + (tmpvar_21.y * _insideTexG)) + (tmpvar_22.z * _insideTexB))) * tmpvar_17)
   * 
    (1.0 - noiseTex_5.x)
  )) * (_InsideIndensity * 50.0));
  highp vec2 tmpvar_24;
  highp vec2 tmpvar_25;
  tmpvar_25 = (xlv_TEXCOORD0.xy * _BgMainTex_ST.xy);
  tmpvar_24 = ((_Time.y * _BgMainTexSpeed) + (tmpvar_25 + _BgMainTex_ST.zw));
  highp vec2 tmpvar_26;
  tmpvar_26 = ((_Time.y * _BgMainTexMaskSpeed) + (tmpvar_25 + _BgMainTex_ST.zw));
  lowp float tmpvar_27;
  tmpvar_27 = clamp (float((
    (texture2D (_BgMainTex, tmpvar_26).x * texture2D (_BgMainTex, tmpvar_24).x)
   >= 0.1)), 0.0, 1.0);
  backGroundTexColor_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (_MainOpacity + (_BgOpacity * (
    (1.0 - mainTex2_4.w)
   * 
    (1.0 - tmpvar_23)
  ))).x;
  OutAlpha_2 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (((
    ((mainTex2_4 * _MainIndensity) * _MainColor)
   + 
    ((_InsideColor * tmpvar_23) * tmpvar_7)
  ) + (
    (((backGroundTexColor_3 * _BgMainTexIntensity) * _BgMainTexColor) * tmpvar_7)
   * OutAlpha_2)) + _BackGroundColor).xyz;
  OutColor_1 = tmpvar_29;
  highp float tmpvar_30;
  mediump float x_31;
  x_31 = (1.0 - rmuv_6.y);
  tmpvar_30 = pow (x_31, _ColorChangePow);
  OutColor_1 = (((OutColor_1 * tmpvar_10) * (tmpvar_30 * _ColorChangeIntensity)) + (OutColor_1 * (1.0 - tmpvar_10)));
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = OutColor_1;
  tmpvar_32.w = OutAlpha_2;
  gl_FragData[0] = tmpvar_32;
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