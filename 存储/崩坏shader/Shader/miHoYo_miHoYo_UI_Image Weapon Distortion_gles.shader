//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Weapon Distortion" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_ColorScaler ("Color Scaler", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
[Toggle(RECT_MASK)] _RectMask ("Rect Mask", Float) = 0
_RMRect ("Rect Mask Rect", Vector) = (0,0,1,1)
_RMTransitWidth ("Rect Mask Transit Width", Vector) = (0,0,0,0)
_ColorMask ("Color Mask", Float) = 15
_DistortionTex ("Distortion Tex (RG)", 2D) = "gray" { }
_DistortionFrequency ("Distortion Frequency", Float) = 1
_DistortionAmplitude ("Distortion Amplitude", Range(0, 1)) = 1
_DistortionAnmSpeed ("Distortion Animation Speed", Float) = 1
_NoiseTex ("Noise Tex (RGB)", 2D) = "black" { }
_NoiseAnmSpeed ("Noise Animation Speed", Float) = 1
_NoiseStrength ("Noise Strength", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstFactor ("DstFactor", Float) = 10
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
  GpuProgramID 23587
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
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _ColorScaler;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ColorScaler * tmpvar_5);
  color_1 = tmpvar_7;
  color_1.xyz = (color_1.xyz * xlv_COLOR.w);
  color_1.xyz = ((1.0 - (
    (1.0 - color_1.xyz)
   * 
    (1.0 - ((tmpvar_4 * _NoiseStrength).xyz * color_1.w))
  )) * _Color.xyz);
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
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _ColorScaler;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ColorScaler * tmpvar_5);
  color_1 = tmpvar_7;
  color_1.xyz = (color_1.xyz * xlv_COLOR.w);
  color_1.xyz = ((1.0 - (
    (1.0 - color_1.xyz)
   * 
    (1.0 - ((tmpvar_4 * _NoiseStrength).xyz * color_1.w))
  )) * _Color.xyz);
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
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _ColorScaler;
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
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_5;
  mediump vec2 P_6;
  P_6 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_5 = texture2D (_MainTex, P_6);
  highp vec4 tmpvar_7;
  tmpvar_7 = (_ColorScaler * tmpvar_5);
  color_1 = tmpvar_7;
  color_1.xyz = (color_1.xyz * xlv_COLOR.w);
  color_1.xyz = ((1.0 - (
    (1.0 - color_1.xyz)
   * 
    (1.0 - ((tmpvar_4 * _NoiseStrength).xyz * color_1.w))
  )) * _Color.xyz);
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
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _ColorScaler;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  mediump float tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_4 = (tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  )));
  tmpvar_3 = ((tmpvar_4.x * tmpvar_4.y) * (tmpvar_4.z * tmpvar_4.w));
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_6;
  offset_2 = (offset_2 * (_DistortionAmplitude * tmpvar_3));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _NoiseStrength) * tmpvar_3).xyz;
  lowp vec4 tmpvar_9;
  mediump vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_9 = texture2D (_MainTex, P_10);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ColorScaler * tmpvar_9);
  color_1 = tmpvar_11;
  color_1.xyz = (color_1.xyz * xlv_COLOR.w);
  if ((tmpvar_3 > 0.0)) {
    color_1.xyz = ((1.0 - (
      (1.0 - color_1.xyz)
     * 
      (1.0 - (tmpvar_8 * color_1.w))
    )) * _Color.xyz);
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
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _ColorScaler;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  mediump float tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_4 = (tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  )));
  tmpvar_3 = ((tmpvar_4.x * tmpvar_4.y) * (tmpvar_4.z * tmpvar_4.w));
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_6;
  offset_2 = (offset_2 * (_DistortionAmplitude * tmpvar_3));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _NoiseStrength) * tmpvar_3).xyz;
  lowp vec4 tmpvar_9;
  mediump vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_9 = texture2D (_MainTex, P_10);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ColorScaler * tmpvar_9);
  color_1 = tmpvar_11;
  color_1.xyz = (color_1.xyz * xlv_COLOR.w);
  if ((tmpvar_3 > 0.0)) {
    color_1.xyz = ((1.0 - (
      (1.0 - color_1.xyz)
     * 
      (1.0 - (tmpvar_8 * color_1.w))
    )) * _Color.xyz);
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
uniform sampler2D _DistortionTex;
uniform mediump float _DistortionAmplitude;
uniform sampler2D _NoiseTex;
uniform mediump float _NoiseStrength;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _ColorScaler;
varying mediump vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 color_1;
  mediump float offset_2;
  mediump float tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = clamp (((
    ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w).xyxy - _RMRect)
   * vec4(1.0, 1.0, -1.0, -1.0)) / max (_RMTransitWidth, vec4(0.0001, 0.0001, 0.0001, 0.0001))), 0.0, 1.0);
  tmpvar_4 = (tmpvar_5 * (tmpvar_5 * (3.0 - 
    (2.0 * tmpvar_5)
  )));
  tmpvar_3 = ((tmpvar_4.x * tmpvar_4.y) * (tmpvar_4.z * tmpvar_4.w));
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DistortionTex, xlv_TEXCOORD1) - 0.498).x;
  offset_2 = tmpvar_6;
  offset_2 = (offset_2 * (_DistortionAmplitude * tmpvar_3));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_NoiseTex, xlv_TEXCOORD2);
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _NoiseStrength) * tmpvar_3).xyz;
  lowp vec4 tmpvar_9;
  mediump vec2 P_10;
  P_10 = (xlv_TEXCOORD0 + offset_2);
  tmpvar_9 = texture2D (_MainTex, P_10);
  highp vec4 tmpvar_11;
  tmpvar_11 = (_ColorScaler * tmpvar_9);
  color_1 = tmpvar_11;
  color_1.xyz = (color_1.xyz * xlv_COLOR.w);
  if ((tmpvar_3 > 0.0)) {
    color_1.xyz = ((1.0 - (
      (1.0 - color_1.xyz)
     * 
      (1.0 - (tmpvar_8 * color_1.w))
    )) * _Color.xyz);
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