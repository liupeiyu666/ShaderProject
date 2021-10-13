//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image TV Distortion" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_BackgroundColor ("Barckground Color (RGBA)", Color) = (0,0,0,1)
_AdjustColor ("Adjust Color (RGB)", Color) = (0,0,0,1)
_DistortionTex ("Distortion Tex (RG)", 2D) = "gray" { }
_DistortionFrequency ("Distortion Frequency", Float) = 1
_DistortionAmplitude ("Distortion Amplitude", Range(0, 1)) = 1
_DistortionAnmSpeed ("Distortion Animation Speed", Float) = 1
_ColorScatterStrength ("Color Scatter Strength", Range(-0.1, 0.1)) = 0.01
_NoiseTex ("Noise Tex (RGB)", 2D) = "black" { }
_NoiseAnmSpeed ("Noise Animation Speed", Float) = 1
_NoiseStrength ("Noise Strength", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 25729
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _DistortionFrequency;
uniform mediump float _DistortionAnmSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseAnmSpeed;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _DistortionAnmSpeed);
  tmpvar_7.y = (_glesMultiTexCoord0.y * _DistortionFrequency);
  tmpvar_4 = tmpvar_7;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec3 tmpvar_8;
  tmpvar_8 = fract((sin(
    (_SinTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_9;
  tmpvar_9 = fract((sin(
    (_CosTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.x = (tmpvar_5.x + ((tmpvar_8.x + tmpvar_9.x) * _NoiseAnmSpeed));
  highp vec3 tmpvar_10;
  tmpvar_10 = fract((sin(
    (_SinTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_11;
  tmpvar_11 = fract((sin(
    (_CosTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.y = (tmpvar_5.y + ((tmpvar_10.x + tmpvar_11.x) * _NoiseAnmSpeed));
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _BackgroundColor;
uniform mediump vec3 _AdjustColor;
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform mediump float _ColorScatterStrength;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_3;
  offset_2 = (offset_2 * _DistortionAmplitude);
  color_1.yz = vec2(0.0, 0.0);
  mediump vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _ColorScatterStrength;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 + offset_2) + tmpvar_4);
  tmpvar_5 = texture2D (_MainTex, P_6);
  color_1.xw = tmpvar_5.xw;
  lowp vec4 tmpvar_7;
  mediump vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_7 = texture2D (_MainTex, P_8);
  color_1.yw = (color_1.yw + tmpvar_7.yw);
  mediump vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = _ColorScatterStrength;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + offset_2) - tmpvar_9);
  tmpvar_10 = texture2D (_MainTex, P_11);
  color_1.zw = (color_1.zw + tmpvar_10.zw);
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  mediump vec4 tmpvar_12;
  if ((color_1.w < 0.5)) {
    tmpvar_12 = _BackgroundColor;
  } else {
    tmpvar_12 = color_1;
  };
  color_1.w = tmpvar_12.w;
  color_1.xyz = (1.0 - ((1.0 - tmpvar_12.xyz) * (1.0 - _AdjustColor)));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  color_1.xyz = (1.0 - ((1.0 - color_1.xyz) * (1.0 - 
    (tmpvar_13 * _NoiseStrength)
  .xyz)));
  gl_FragData[0] = color_1;
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
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _DistortionFrequency;
uniform mediump float _DistortionAnmSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseAnmSpeed;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _DistortionAnmSpeed);
  tmpvar_7.y = (_glesMultiTexCoord0.y * _DistortionFrequency);
  tmpvar_4 = tmpvar_7;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec3 tmpvar_8;
  tmpvar_8 = fract((sin(
    (_SinTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_9;
  tmpvar_9 = fract((sin(
    (_CosTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.x = (tmpvar_5.x + ((tmpvar_8.x + tmpvar_9.x) * _NoiseAnmSpeed));
  highp vec3 tmpvar_10;
  tmpvar_10 = fract((sin(
    (_SinTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_11;
  tmpvar_11 = fract((sin(
    (_CosTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.y = (tmpvar_5.y + ((tmpvar_10.x + tmpvar_11.x) * _NoiseAnmSpeed));
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _BackgroundColor;
uniform mediump vec3 _AdjustColor;
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform mediump float _ColorScatterStrength;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_3;
  offset_2 = (offset_2 * _DistortionAmplitude);
  color_1.yz = vec2(0.0, 0.0);
  mediump vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _ColorScatterStrength;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 + offset_2) + tmpvar_4);
  tmpvar_5 = texture2D (_MainTex, P_6);
  color_1.xw = tmpvar_5.xw;
  lowp vec4 tmpvar_7;
  mediump vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_7 = texture2D (_MainTex, P_8);
  color_1.yw = (color_1.yw + tmpvar_7.yw);
  mediump vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = _ColorScatterStrength;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + offset_2) - tmpvar_9);
  tmpvar_10 = texture2D (_MainTex, P_11);
  color_1.zw = (color_1.zw + tmpvar_10.zw);
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  mediump vec4 tmpvar_12;
  if ((color_1.w < 0.5)) {
    tmpvar_12 = _BackgroundColor;
  } else {
    tmpvar_12 = color_1;
  };
  color_1.w = tmpvar_12.w;
  color_1.xyz = (1.0 - ((1.0 - tmpvar_12.xyz) * (1.0 - _AdjustColor)));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  color_1.xyz = (1.0 - ((1.0 - color_1.xyz) * (1.0 - 
    (tmpvar_13 * _NoiseStrength)
  .xyz)));
  gl_FragData[0] = color_1;
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
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _DistortionFrequency;
uniform mediump float _DistortionAnmSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseAnmSpeed;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  highp vec2 tmpvar_7;
  tmpvar_7.x = (_Time.y * _DistortionAnmSpeed);
  tmpvar_7.y = (_glesMultiTexCoord0.y * _DistortionFrequency);
  tmpvar_4 = tmpvar_7;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec3 tmpvar_8;
  tmpvar_8 = fract((sin(
    (_SinTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_9;
  tmpvar_9 = fract((sin(
    (_CosTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.x = (tmpvar_5.x + ((tmpvar_8.x + tmpvar_9.x) * _NoiseAnmSpeed));
  highp vec3 tmpvar_10;
  tmpvar_10 = fract((sin(
    (_SinTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_11;
  tmpvar_11 = fract((sin(
    (_CosTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.y = (tmpvar_5.y + ((tmpvar_10.x + tmpvar_11.x) * _NoiseAnmSpeed));
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _BackgroundColor;
uniform mediump vec3 _AdjustColor;
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform mediump float _ColorScatterStrength;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_3;
  offset_2 = (offset_2 * _DistortionAmplitude);
  color_1.yz = vec2(0.0, 0.0);
  mediump vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _ColorScatterStrength;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 + offset_2) + tmpvar_4);
  tmpvar_5 = texture2D (_MainTex, P_6);
  color_1.xw = tmpvar_5.xw;
  lowp vec4 tmpvar_7;
  mediump vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_7 = texture2D (_MainTex, P_8);
  color_1.yw = (color_1.yw + tmpvar_7.yw);
  mediump vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = _ColorScatterStrength;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + offset_2) - tmpvar_9);
  tmpvar_10 = texture2D (_MainTex, P_11);
  color_1.zw = (color_1.zw + tmpvar_10.zw);
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  mediump vec4 tmpvar_12;
  if ((color_1.w < 0.5)) {
    tmpvar_12 = _BackgroundColor;
  } else {
    tmpvar_12 = color_1;
  };
  color_1.w = tmpvar_12.w;
  color_1.xyz = (1.0 - ((1.0 - tmpvar_12.xyz) * (1.0 - _AdjustColor)));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  color_1.xyz = (1.0 - ((1.0 - color_1.xyz) * (1.0 - 
    (tmpvar_13 * _NoiseStrength)
  .xyz)));
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
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _DistortionFrequency;
uniform mediump float _DistortionAnmSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseAnmSpeed;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = tmpvar_1;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _DistortionAnmSpeed);
  tmpvar_9.y = (_glesMultiTexCoord0.y * _DistortionFrequency);
  tmpvar_4 = tmpvar_9;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec3 tmpvar_10;
  tmpvar_10 = fract((sin(
    (_SinTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_11;
  tmpvar_11 = fract((sin(
    (_CosTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.x = (tmpvar_5.x + ((tmpvar_10.x + tmpvar_11.x) * _NoiseAnmSpeed));
  highp vec3 tmpvar_12;
  tmpvar_12 = fract((sin(
    (_SinTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_13;
  tmpvar_13 = fract((sin(
    (_CosTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.y = (tmpvar_5.y + ((tmpvar_12.x + tmpvar_13.x) * _NoiseAnmSpeed));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_6 = o_14;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _BackgroundColor;
uniform mediump vec3 _AdjustColor;
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform mediump float _ColorScatterStrength;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_3;
  offset_2 = (offset_2 * _DistortionAmplitude);
  color_1.yz = vec2(0.0, 0.0);
  mediump vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _ColorScatterStrength;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 + offset_2) + tmpvar_4);
  tmpvar_5 = texture2D (_MainTex, P_6);
  color_1.xw = tmpvar_5.xw;
  lowp vec4 tmpvar_7;
  mediump vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_7 = texture2D (_MainTex, P_8);
  color_1.yw = (color_1.yw + tmpvar_7.yw);
  mediump vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = _ColorScatterStrength;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + offset_2) - tmpvar_9);
  tmpvar_10 = texture2D (_MainTex, P_11);
  color_1.zw = (color_1.zw + tmpvar_10.zw);
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  mediump vec4 tmpvar_12;
  if ((color_1.w < 0.5)) {
    tmpvar_12 = _BackgroundColor;
  } else {
    tmpvar_12 = color_1;
  };
  color_1.w = tmpvar_12.w;
  color_1.xyz = (1.0 - ((1.0 - tmpvar_12.xyz) * (1.0 - _AdjustColor)));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  color_1.xyz = (1.0 - ((1.0 - color_1.xyz) * (1.0 - 
    (tmpvar_13 * _NoiseStrength)
  .xyz)));
  mediump vec4 tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_14 = (tmpvar_15 * (tmpvar_15 * (3.0 - 
    (2.0 * tmpvar_15)
  )));
  color_1.w = ((tmpvar_12.w * tmpvar_14.x) * ((tmpvar_14.y * tmpvar_14.z) * tmpvar_14.w));
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
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _DistortionFrequency;
uniform mediump float _DistortionAnmSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseAnmSpeed;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = tmpvar_1;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _DistortionAnmSpeed);
  tmpvar_9.y = (_glesMultiTexCoord0.y * _DistortionFrequency);
  tmpvar_4 = tmpvar_9;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec3 tmpvar_10;
  tmpvar_10 = fract((sin(
    (_SinTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_11;
  tmpvar_11 = fract((sin(
    (_CosTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.x = (tmpvar_5.x + ((tmpvar_10.x + tmpvar_11.x) * _NoiseAnmSpeed));
  highp vec3 tmpvar_12;
  tmpvar_12 = fract((sin(
    (_SinTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_13;
  tmpvar_13 = fract((sin(
    (_CosTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.y = (tmpvar_5.y + ((tmpvar_12.x + tmpvar_13.x) * _NoiseAnmSpeed));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_6 = o_14;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _BackgroundColor;
uniform mediump vec3 _AdjustColor;
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform mediump float _ColorScatterStrength;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_3;
  offset_2 = (offset_2 * _DistortionAmplitude);
  color_1.yz = vec2(0.0, 0.0);
  mediump vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _ColorScatterStrength;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 + offset_2) + tmpvar_4);
  tmpvar_5 = texture2D (_MainTex, P_6);
  color_1.xw = tmpvar_5.xw;
  lowp vec4 tmpvar_7;
  mediump vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_7 = texture2D (_MainTex, P_8);
  color_1.yw = (color_1.yw + tmpvar_7.yw);
  mediump vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = _ColorScatterStrength;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + offset_2) - tmpvar_9);
  tmpvar_10 = texture2D (_MainTex, P_11);
  color_1.zw = (color_1.zw + tmpvar_10.zw);
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  mediump vec4 tmpvar_12;
  if ((color_1.w < 0.5)) {
    tmpvar_12 = _BackgroundColor;
  } else {
    tmpvar_12 = color_1;
  };
  color_1.w = tmpvar_12.w;
  color_1.xyz = (1.0 - ((1.0 - tmpvar_12.xyz) * (1.0 - _AdjustColor)));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  color_1.xyz = (1.0 - ((1.0 - color_1.xyz) * (1.0 - 
    (tmpvar_13 * _NoiseStrength)
  .xyz)));
  mediump vec4 tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_14 = (tmpvar_15 * (tmpvar_15 * (3.0 - 
    (2.0 * tmpvar_15)
  )));
  color_1.w = ((tmpvar_12.w * tmpvar_14.x) * ((tmpvar_14.y * tmpvar_14.z) * tmpvar_14.w));
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
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform highp vec4 _CosTime;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _DistortionFrequency;
uniform mediump float _DistortionAnmSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseAnmSpeed;
uniform mediump vec4 _Color;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_3 = tmpvar_1;
  highp vec2 tmpvar_9;
  tmpvar_9.x = (_Time.y * _DistortionAnmSpeed);
  tmpvar_9.y = (_glesMultiTexCoord0.y * _DistortionFrequency);
  tmpvar_4 = tmpvar_9;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  highp vec3 tmpvar_10;
  tmpvar_10 = fract((sin(
    (_SinTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_11;
  tmpvar_11 = fract((sin(
    (_CosTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.x = (tmpvar_5.x + ((tmpvar_10.x + tmpvar_11.x) * _NoiseAnmSpeed));
  highp vec3 tmpvar_12;
  tmpvar_12 = fract((sin(
    (_SinTime.x * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  highp vec3 tmpvar_13;
  tmpvar_13 = fract((sin(
    (_CosTime.w * vec3(12.9898, 78.233, 45.5432))
  ) * 43758.55));
  tmpvar_5.y = (tmpvar_5.y + ((tmpvar_12.x + tmpvar_13.x) * _NoiseAnmSpeed));
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_7.zw;
  tmpvar_6 = o_14;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_7;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD4 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _RMRect;
uniform mediump vec4 _RMTransitWidth;
uniform mediump vec4 _BackgroundColor;
uniform mediump vec3 _AdjustColor;
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform mediump float _ColorScatterStrength;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  lowp float tmpvar_3;
  tmpvar_3 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_3;
  offset_2 = (offset_2 * _DistortionAmplitude);
  color_1.yz = vec2(0.0, 0.0);
  mediump vec2 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _ColorScatterStrength;
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 + offset_2) + tmpvar_4);
  tmpvar_5 = texture2D (_MainTex, P_6);
  color_1.xw = tmpvar_5.xw;
  lowp vec4 tmpvar_7;
  mediump vec2 P_8;
  P_8 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_7 = texture2D (_MainTex, P_8);
  color_1.yw = (color_1.yw + tmpvar_7.yw);
  mediump vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = _ColorScatterStrength;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((xlv_TEXCOORD0 + offset_2) - tmpvar_9);
  tmpvar_10 = texture2D (_MainTex, P_11);
  color_1.zw = (color_1.zw + tmpvar_10.zw);
  color_1.xyz = (color_1.xyz * xlv_COLOR.xyz);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  mediump vec4 tmpvar_12;
  if ((color_1.w < 0.5)) {
    tmpvar_12 = _BackgroundColor;
  } else {
    tmpvar_12 = color_1;
  };
  color_1.w = tmpvar_12.w;
  color_1.xyz = (1.0 - ((1.0 - tmpvar_12.xyz) * (1.0 - _AdjustColor)));
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  color_1.xyz = (1.0 - ((1.0 - color_1.xyz) * (1.0 - 
    (tmpvar_13 * _NoiseStrength)
  .xyz)));
  mediump vec4 tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_14 = (tmpvar_15 * (tmpvar_15 * (3.0 - 
    (2.0 * tmpvar_15)
  )));
  color_1.w = ((tmpvar_12.w * tmpvar_14.x) * ((tmpvar_14.y * tmpvar_14.z) * tmpvar_14.w));
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
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 75992
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
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
}
}
}
}