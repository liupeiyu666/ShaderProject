//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/Smoke" {
Properties {
_LightColor ("LightColor", Color) = (0.097,0.097,0.097,0)
_DarkColor ("DarkColor", Color) = (0.038,0.038,0.038,0)
_RimColor ("RimColor", Color) = (0.5441177,0.5441177,0.5441177,0)
_SmokeShape ("SmokeShape", 2D) = "white" { }
_Distortion ("Distortion", 2D) = "white" { }
_DistortionStrength ("Distortion Strength", Range(-0.1, 0.1)) = 0
[MHYToggle] _DistortWithTime ("Distort With Time", Float) = 0
_LoopTime ("LoopTime", Range(0, 5)) = 1
[MHYToggle] _DiaPearByTime ("DiaPear By Time", Float) = 0
_dispearSpeed ("dispearSpeed", Range(0, 5)) = 1
_StartDispearTime ("Start Dispear Time", Float) = 0.2
_TransparentNoise ("Transparent Noise", 2D) = "white" { }
_AlphaMuliplier ("Alpha Muliplier", Float) = 1
_NoiseDistortion ("Noise Distortion", 2D) = "white" { }
_NoiseDistortionSpeedXUspeedYVSpeed ("Noise Distortion Speed (X:Uspeed. Y:VSpeed)", Vector) = (0,0.1,0,0)
_NoiseDistortionStrength ("Noise Distortion Strength", Float) = 0.1
[Header(Motion Vectors)] _MotionVectorsAlphaCutoff ("Motion Vectors Alpha Cutoff", Range(0, 1)) = 0.1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 58973
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec4 lerpResult143_2;
  mediump vec4 lerpResult142_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (_DarkColor, _LightColor, tex2DNode122_7.xxxx);
  lerpResult142_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (lerpResult142_3, _RimColor, tex2DNode122_7.yyyy);
  lerpResult143_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_27 = texture2D (_NoiseDistortion, P_28);
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_27.x * _NoiseDistortionStrength));
  tmpvar_29 = texture2D (_TransparentNoise, P_30);
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((staticSwitch154_6 * tmpvar_29.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (xlv_COLOR * lerpResult143_2).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = aseOutColor_1;
  tmpvar_34.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = tmpvar_34;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec4 lerpResult143_2;
  mediump vec4 lerpResult142_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (_DarkColor, _LightColor, tex2DNode122_7.xxxx);
  lerpResult142_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (lerpResult142_3, _RimColor, tex2DNode122_7.yyyy);
  lerpResult143_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_27 = texture2D (_NoiseDistortion, P_28);
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_27.x * _NoiseDistortionStrength));
  tmpvar_29 = texture2D (_TransparentNoise, P_30);
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((staticSwitch154_6 * tmpvar_29.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (xlv_COLOR * lerpResult143_2).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = aseOutColor_1;
  tmpvar_34.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = tmpvar_34;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec4 lerpResult143_2;
  mediump vec4 lerpResult142_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (_DarkColor, _LightColor, tex2DNode122_7.xxxx);
  lerpResult142_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (lerpResult142_3, _RimColor, tex2DNode122_7.yyyy);
  lerpResult143_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_27 = texture2D (_NoiseDistortion, P_28);
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_27.x * _NoiseDistortionStrength));
  tmpvar_29 = texture2D (_TransparentNoise, P_30);
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((staticSwitch154_6 * tmpvar_29.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (xlv_COLOR * lerpResult143_2).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = aseOutColor_1;
  tmpvar_34.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = tmpvar_34;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec4 lerpResult143_2;
  mediump vec4 lerpResult142_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (_DarkColor, _LightColor, tex2DNode122_7.xxxx);
  lerpResult142_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (lerpResult142_3, _RimColor, tex2DNode122_7.yyyy);
  lerpResult143_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_27 = texture2D (_NoiseDistortion, P_28);
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_27.x * _NoiseDistortionStrength));
  tmpvar_29 = texture2D (_TransparentNoise, P_30);
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((staticSwitch154_6 * tmpvar_29.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (xlv_COLOR * lerpResult143_2).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = aseOutColor_1;
  tmpvar_34.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = tmpvar_34;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec4 lerpResult143_2;
  mediump vec4 lerpResult142_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (_DarkColor, _LightColor, tex2DNode122_7.xxxx);
  lerpResult142_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (lerpResult142_3, _RimColor, tex2DNode122_7.yyyy);
  lerpResult143_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_27 = texture2D (_NoiseDistortion, P_28);
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_27.x * _NoiseDistortionStrength));
  tmpvar_29 = texture2D (_TransparentNoise, P_30);
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((staticSwitch154_6 * tmpvar_29.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (xlv_COLOR * lerpResult143_2).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = aseOutColor_1;
  tmpvar_34.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = tmpvar_34;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec4 lerpResult143_2;
  mediump vec4 lerpResult142_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = mix (_DarkColor, _LightColor, tex2DNode122_7.xxxx);
  lerpResult142_3 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (lerpResult142_3, _RimColor, tex2DNode122_7.yyyy);
  lerpResult143_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_27 = texture2D (_NoiseDistortion, P_28);
  lowp vec4 tmpvar_29;
  mediump vec2 P_30;
  P_30 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_27.x * _NoiseDistortionStrength));
  tmpvar_29 = texture2D (_TransparentNoise, P_30);
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (((staticSwitch154_6 * tmpvar_29.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (xlv_COLOR * lerpResult143_2).xyz;
  aseOutColor_1 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = aseOutColor_1;
  tmpvar_34.w = clamp (tmpvar_31, 0.0, 1.0);
  gl_FragData[0] = tmpvar_34;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump vec4 lerpResult143_3;
  mediump vec4 lerpResult142_4;
  mediump vec2 uv_NoiseDistortion_5;
  mediump vec2 uv_TransparentNoise_6;
  mediump float staticSwitch154_7;
  mediump vec4 tex2DNode122_8;
  mediump float staticSwitch134_9;
  mediump float mulTime131_10;
  mediump vec2 uv_SmokeShape_11;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_12;
    tmpvar_12 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
    uv_SmokeShape_11 = tmpvar_12;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
    highp float tmpvar_14;
    tmpvar_14 = _Time.y;
    mulTime131_10 = tmpvar_14;
    mediump float tmpvar_15;
    tmpvar_15 = (mulTime131_10 / _LoopTime);
    mediump float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * _LoopTime);
    mediump float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    staticSwitch134_9 = 0.0;
    if ((_DistortWithTime == 1.0)) {
      staticSwitch134_9 = (_DistortionStrength * tmpvar_17);
    } else {
      staticSwitch134_9 = _DistortionStrength;
    };
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_Distortion, tmpvar_13);
    mediump vec2 tmpvar_19;
    tmpvar_19 = (((tmpvar_18.xy * 2.0) + -1.0) * staticSwitch134_9);
    lowp vec4 tmpvar_20;
    mediump vec2 P_21;
    P_21 = (uv_SmokeShape_11 + tmpvar_19);
    tmpvar_20 = texture2D (_SmokeShape, P_21);
    tex2DNode122_8 = tmpvar_20;
    mediump float tmpvar_22;
    mediump float tmpvar_23;
    tmpvar_23 = clamp (((
      (1.0 - tex2DNode122_8.z)
     + 
      (-(max ((tmpvar_17 - _StartDispearTime), 0.0)) * _dispearSpeed)
    ) / 0.1), 0.0, 1.0);
    tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
      (2.0 * tmpvar_23)
    )));
    staticSwitch154_7 = 0.0;
    if ((_DiaPearByTime == 1.0)) {
      staticSwitch154_7 = (tex2DNode122_8.w * tmpvar_22);
    } else {
      staticSwitch154_7 = tex2DNode122_8.w;
    };
    highp vec2 tmpvar_24;
    tmpvar_24 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
    uv_TransparentNoise_6 = tmpvar_24;
    highp vec2 tmpvar_25;
    tmpvar_25 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
    uv_NoiseDistortion_5 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = mix (_DarkColor, _LightColor, tex2DNode122_8.xxxx);
    lerpResult142_4 = tmpvar_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = mix (lerpResult142_4, _RimColor, tex2DNode122_8.yyyy);
    lerpResult143_3 = tmpvar_27;
    lowp vec4 tmpvar_28;
    mediump vec2 P_29;
    P_29 = ((tmpvar_17 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_5);
    tmpvar_28 = texture2D (_NoiseDistortion, P_29);
    lowp vec4 tmpvar_30;
    mediump vec2 P_31;
    P_31 = ((tmpvar_19 + uv_TransparentNoise_6) + (tmpvar_28.x * _NoiseDistortionStrength));
    tmpvar_30 = texture2D (_TransparentNoise, P_31);
    mediump float tmpvar_32;
    highp float tmpvar_33;
    tmpvar_33 = clamp (((staticSwitch154_7 * tmpvar_30.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
    tmpvar_32 = tmpvar_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = (xlv_COLOR * lerpResult143_3).xyz;
    aseOutColor_2 = tmpvar_34;
    mediump vec4 tmpvar_35;
    tmpvar_35.xyz = aseOutColor_2;
    tmpvar_35.w = clamp (tmpvar_32, 0.0, 1.0);
    tmpvar_1 = tmpvar_35;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump vec4 lerpResult143_3;
  mediump vec4 lerpResult142_4;
  mediump vec2 uv_NoiseDistortion_5;
  mediump vec2 uv_TransparentNoise_6;
  mediump float staticSwitch154_7;
  mediump vec4 tex2DNode122_8;
  mediump float staticSwitch134_9;
  mediump float mulTime131_10;
  mediump vec2 uv_SmokeShape_11;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_12;
    tmpvar_12 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
    uv_SmokeShape_11 = tmpvar_12;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
    highp float tmpvar_14;
    tmpvar_14 = _Time.y;
    mulTime131_10 = tmpvar_14;
    mediump float tmpvar_15;
    tmpvar_15 = (mulTime131_10 / _LoopTime);
    mediump float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * _LoopTime);
    mediump float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    staticSwitch134_9 = 0.0;
    if ((_DistortWithTime == 1.0)) {
      staticSwitch134_9 = (_DistortionStrength * tmpvar_17);
    } else {
      staticSwitch134_9 = _DistortionStrength;
    };
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_Distortion, tmpvar_13);
    mediump vec2 tmpvar_19;
    tmpvar_19 = (((tmpvar_18.xy * 2.0) + -1.0) * staticSwitch134_9);
    lowp vec4 tmpvar_20;
    mediump vec2 P_21;
    P_21 = (uv_SmokeShape_11 + tmpvar_19);
    tmpvar_20 = texture2D (_SmokeShape, P_21);
    tex2DNode122_8 = tmpvar_20;
    mediump float tmpvar_22;
    mediump float tmpvar_23;
    tmpvar_23 = clamp (((
      (1.0 - tex2DNode122_8.z)
     + 
      (-(max ((tmpvar_17 - _StartDispearTime), 0.0)) * _dispearSpeed)
    ) / 0.1), 0.0, 1.0);
    tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
      (2.0 * tmpvar_23)
    )));
    staticSwitch154_7 = 0.0;
    if ((_DiaPearByTime == 1.0)) {
      staticSwitch154_7 = (tex2DNode122_8.w * tmpvar_22);
    } else {
      staticSwitch154_7 = tex2DNode122_8.w;
    };
    highp vec2 tmpvar_24;
    tmpvar_24 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
    uv_TransparentNoise_6 = tmpvar_24;
    highp vec2 tmpvar_25;
    tmpvar_25 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
    uv_NoiseDistortion_5 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = mix (_DarkColor, _LightColor, tex2DNode122_8.xxxx);
    lerpResult142_4 = tmpvar_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = mix (lerpResult142_4, _RimColor, tex2DNode122_8.yyyy);
    lerpResult143_3 = tmpvar_27;
    lowp vec4 tmpvar_28;
    mediump vec2 P_29;
    P_29 = ((tmpvar_17 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_5);
    tmpvar_28 = texture2D (_NoiseDistortion, P_29);
    lowp vec4 tmpvar_30;
    mediump vec2 P_31;
    P_31 = ((tmpvar_19 + uv_TransparentNoise_6) + (tmpvar_28.x * _NoiseDistortionStrength));
    tmpvar_30 = texture2D (_TransparentNoise, P_31);
    mediump float tmpvar_32;
    highp float tmpvar_33;
    tmpvar_33 = clamp (((staticSwitch154_7 * tmpvar_30.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
    tmpvar_32 = tmpvar_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = (xlv_COLOR * lerpResult143_3).xyz;
    aseOutColor_2 = tmpvar_34;
    mediump vec4 tmpvar_35;
    tmpvar_35.xyz = aseOutColor_2;
    tmpvar_35.w = clamp (tmpvar_32, 0.0, 1.0);
    tmpvar_1 = tmpvar_35;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump vec4 lerpResult143_3;
  mediump vec4 lerpResult142_4;
  mediump vec2 uv_NoiseDistortion_5;
  mediump vec2 uv_TransparentNoise_6;
  mediump float staticSwitch154_7;
  mediump vec4 tex2DNode122_8;
  mediump float staticSwitch134_9;
  mediump float mulTime131_10;
  mediump vec2 uv_SmokeShape_11;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_12;
    tmpvar_12 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
    uv_SmokeShape_11 = tmpvar_12;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
    highp float tmpvar_14;
    tmpvar_14 = _Time.y;
    mulTime131_10 = tmpvar_14;
    mediump float tmpvar_15;
    tmpvar_15 = (mulTime131_10 / _LoopTime);
    mediump float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * _LoopTime);
    mediump float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    staticSwitch134_9 = 0.0;
    if ((_DistortWithTime == 1.0)) {
      staticSwitch134_9 = (_DistortionStrength * tmpvar_17);
    } else {
      staticSwitch134_9 = _DistortionStrength;
    };
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_Distortion, tmpvar_13);
    mediump vec2 tmpvar_19;
    tmpvar_19 = (((tmpvar_18.xy * 2.0) + -1.0) * staticSwitch134_9);
    lowp vec4 tmpvar_20;
    mediump vec2 P_21;
    P_21 = (uv_SmokeShape_11 + tmpvar_19);
    tmpvar_20 = texture2D (_SmokeShape, P_21);
    tex2DNode122_8 = tmpvar_20;
    mediump float tmpvar_22;
    mediump float tmpvar_23;
    tmpvar_23 = clamp (((
      (1.0 - tex2DNode122_8.z)
     + 
      (-(max ((tmpvar_17 - _StartDispearTime), 0.0)) * _dispearSpeed)
    ) / 0.1), 0.0, 1.0);
    tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
      (2.0 * tmpvar_23)
    )));
    staticSwitch154_7 = 0.0;
    if ((_DiaPearByTime == 1.0)) {
      staticSwitch154_7 = (tex2DNode122_8.w * tmpvar_22);
    } else {
      staticSwitch154_7 = tex2DNode122_8.w;
    };
    highp vec2 tmpvar_24;
    tmpvar_24 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
    uv_TransparentNoise_6 = tmpvar_24;
    highp vec2 tmpvar_25;
    tmpvar_25 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
    uv_NoiseDistortion_5 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = mix (_DarkColor, _LightColor, tex2DNode122_8.xxxx);
    lerpResult142_4 = tmpvar_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = mix (lerpResult142_4, _RimColor, tex2DNode122_8.yyyy);
    lerpResult143_3 = tmpvar_27;
    lowp vec4 tmpvar_28;
    mediump vec2 P_29;
    P_29 = ((tmpvar_17 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_5);
    tmpvar_28 = texture2D (_NoiseDistortion, P_29);
    lowp vec4 tmpvar_30;
    mediump vec2 P_31;
    P_31 = ((tmpvar_19 + uv_TransparentNoise_6) + (tmpvar_28.x * _NoiseDistortionStrength));
    tmpvar_30 = texture2D (_TransparentNoise, P_31);
    mediump float tmpvar_32;
    highp float tmpvar_33;
    tmpvar_33 = clamp (((staticSwitch154_7 * tmpvar_30.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
    tmpvar_32 = tmpvar_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = (xlv_COLOR * lerpResult143_3).xyz;
    aseOutColor_2 = tmpvar_34;
    mediump vec4 tmpvar_35;
    tmpvar_35.xyz = aseOutColor_2;
    tmpvar_35.w = clamp (tmpvar_32, 0.0, 1.0);
    tmpvar_1 = tmpvar_35;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump vec4 lerpResult143_3;
  mediump vec4 lerpResult142_4;
  mediump vec2 uv_NoiseDistortion_5;
  mediump vec2 uv_TransparentNoise_6;
  mediump float staticSwitch154_7;
  mediump vec4 tex2DNode122_8;
  mediump float staticSwitch134_9;
  mediump float mulTime131_10;
  mediump vec2 uv_SmokeShape_11;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_12;
    tmpvar_12 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
    uv_SmokeShape_11 = tmpvar_12;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
    highp float tmpvar_14;
    tmpvar_14 = _Time.y;
    mulTime131_10 = tmpvar_14;
    mediump float tmpvar_15;
    tmpvar_15 = (mulTime131_10 / _LoopTime);
    mediump float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * _LoopTime);
    mediump float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    staticSwitch134_9 = 0.0;
    if ((_DistortWithTime == 1.0)) {
      staticSwitch134_9 = (_DistortionStrength * tmpvar_17);
    } else {
      staticSwitch134_9 = _DistortionStrength;
    };
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_Distortion, tmpvar_13);
    mediump vec2 tmpvar_19;
    tmpvar_19 = (((tmpvar_18.xy * 2.0) + -1.0) * staticSwitch134_9);
    lowp vec4 tmpvar_20;
    mediump vec2 P_21;
    P_21 = (uv_SmokeShape_11 + tmpvar_19);
    tmpvar_20 = texture2D (_SmokeShape, P_21);
    tex2DNode122_8 = tmpvar_20;
    mediump float tmpvar_22;
    mediump float tmpvar_23;
    tmpvar_23 = clamp (((
      (1.0 - tex2DNode122_8.z)
     + 
      (-(max ((tmpvar_17 - _StartDispearTime), 0.0)) * _dispearSpeed)
    ) / 0.1), 0.0, 1.0);
    tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
      (2.0 * tmpvar_23)
    )));
    staticSwitch154_7 = 0.0;
    if ((_DiaPearByTime == 1.0)) {
      staticSwitch154_7 = (tex2DNode122_8.w * tmpvar_22);
    } else {
      staticSwitch154_7 = tex2DNode122_8.w;
    };
    highp vec2 tmpvar_24;
    tmpvar_24 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
    uv_TransparentNoise_6 = tmpvar_24;
    highp vec2 tmpvar_25;
    tmpvar_25 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
    uv_NoiseDistortion_5 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = mix (_DarkColor, _LightColor, tex2DNode122_8.xxxx);
    lerpResult142_4 = tmpvar_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = mix (lerpResult142_4, _RimColor, tex2DNode122_8.yyyy);
    lerpResult143_3 = tmpvar_27;
    lowp vec4 tmpvar_28;
    mediump vec2 P_29;
    P_29 = ((tmpvar_17 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_5);
    tmpvar_28 = texture2D (_NoiseDistortion, P_29);
    lowp vec4 tmpvar_30;
    mediump vec2 P_31;
    P_31 = ((tmpvar_19 + uv_TransparentNoise_6) + (tmpvar_28.x * _NoiseDistortionStrength));
    tmpvar_30 = texture2D (_TransparentNoise, P_31);
    mediump float tmpvar_32;
    highp float tmpvar_33;
    tmpvar_33 = clamp (((staticSwitch154_7 * tmpvar_30.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
    tmpvar_32 = tmpvar_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = (xlv_COLOR * lerpResult143_3).xyz;
    aseOutColor_2 = tmpvar_34;
    mediump vec4 tmpvar_35;
    tmpvar_35.xyz = aseOutColor_2;
    tmpvar_35.w = clamp (tmpvar_32, 0.0, 1.0);
    tmpvar_1 = tmpvar_35;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump vec4 lerpResult143_3;
  mediump vec4 lerpResult142_4;
  mediump vec2 uv_NoiseDistortion_5;
  mediump vec2 uv_TransparentNoise_6;
  mediump float staticSwitch154_7;
  mediump vec4 tex2DNode122_8;
  mediump float staticSwitch134_9;
  mediump float mulTime131_10;
  mediump vec2 uv_SmokeShape_11;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_12;
    tmpvar_12 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
    uv_SmokeShape_11 = tmpvar_12;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
    highp float tmpvar_14;
    tmpvar_14 = _Time.y;
    mulTime131_10 = tmpvar_14;
    mediump float tmpvar_15;
    tmpvar_15 = (mulTime131_10 / _LoopTime);
    mediump float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * _LoopTime);
    mediump float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    staticSwitch134_9 = 0.0;
    if ((_DistortWithTime == 1.0)) {
      staticSwitch134_9 = (_DistortionStrength * tmpvar_17);
    } else {
      staticSwitch134_9 = _DistortionStrength;
    };
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_Distortion, tmpvar_13);
    mediump vec2 tmpvar_19;
    tmpvar_19 = (((tmpvar_18.xy * 2.0) + -1.0) * staticSwitch134_9);
    lowp vec4 tmpvar_20;
    mediump vec2 P_21;
    P_21 = (uv_SmokeShape_11 + tmpvar_19);
    tmpvar_20 = texture2D (_SmokeShape, P_21);
    tex2DNode122_8 = tmpvar_20;
    mediump float tmpvar_22;
    mediump float tmpvar_23;
    tmpvar_23 = clamp (((
      (1.0 - tex2DNode122_8.z)
     + 
      (-(max ((tmpvar_17 - _StartDispearTime), 0.0)) * _dispearSpeed)
    ) / 0.1), 0.0, 1.0);
    tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
      (2.0 * tmpvar_23)
    )));
    staticSwitch154_7 = 0.0;
    if ((_DiaPearByTime == 1.0)) {
      staticSwitch154_7 = (tex2DNode122_8.w * tmpvar_22);
    } else {
      staticSwitch154_7 = tex2DNode122_8.w;
    };
    highp vec2 tmpvar_24;
    tmpvar_24 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
    uv_TransparentNoise_6 = tmpvar_24;
    highp vec2 tmpvar_25;
    tmpvar_25 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
    uv_NoiseDistortion_5 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = mix (_DarkColor, _LightColor, tex2DNode122_8.xxxx);
    lerpResult142_4 = tmpvar_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = mix (lerpResult142_4, _RimColor, tex2DNode122_8.yyyy);
    lerpResult143_3 = tmpvar_27;
    lowp vec4 tmpvar_28;
    mediump vec2 P_29;
    P_29 = ((tmpvar_17 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_5);
    tmpvar_28 = texture2D (_NoiseDistortion, P_29);
    lowp vec4 tmpvar_30;
    mediump vec2 P_31;
    P_31 = ((tmpvar_19 + uv_TransparentNoise_6) + (tmpvar_28.x * _NoiseDistortionStrength));
    tmpvar_30 = texture2D (_TransparentNoise, P_31);
    mediump float tmpvar_32;
    highp float tmpvar_33;
    tmpvar_33 = clamp (((staticSwitch154_7 * tmpvar_30.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
    tmpvar_32 = tmpvar_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = (xlv_COLOR * lerpResult143_3).xyz;
    aseOutColor_2 = tmpvar_34;
    mediump vec4 tmpvar_35;
    tmpvar_35.xyz = aseOutColor_2;
    tmpvar_35.w = clamp (tmpvar_32, 0.0, 1.0);
    tmpvar_1 = tmpvar_35;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2.xyw = tmpvar_3.xyw;
  tmpvar_2.z = (tmpvar_3.z + (_MHYZBias * tmpvar_3.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp vec4 _RimColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump vec4 lerpResult143_3;
  mediump vec4 lerpResult142_4;
  mediump vec2 uv_NoiseDistortion_5;
  mediump vec2 uv_TransparentNoise_6;
  mediump float staticSwitch154_7;
  mediump vec4 tex2DNode122_8;
  mediump float staticSwitch134_9;
  mediump float mulTime131_10;
  mediump vec2 uv_SmokeShape_11;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_12;
    tmpvar_12 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
    uv_SmokeShape_11 = tmpvar_12;
    highp vec2 tmpvar_13;
    tmpvar_13 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
    highp float tmpvar_14;
    tmpvar_14 = _Time.y;
    mulTime131_10 = tmpvar_14;
    mediump float tmpvar_15;
    tmpvar_15 = (mulTime131_10 / _LoopTime);
    mediump float tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * _LoopTime);
    mediump float tmpvar_17;
    if ((tmpvar_15 >= 0.0)) {
      tmpvar_17 = tmpvar_16;
    } else {
      tmpvar_17 = -(tmpvar_16);
    };
    staticSwitch134_9 = 0.0;
    if ((_DistortWithTime == 1.0)) {
      staticSwitch134_9 = (_DistortionStrength * tmpvar_17);
    } else {
      staticSwitch134_9 = _DistortionStrength;
    };
    lowp vec4 tmpvar_18;
    tmpvar_18 = texture2D (_Distortion, tmpvar_13);
    mediump vec2 tmpvar_19;
    tmpvar_19 = (((tmpvar_18.xy * 2.0) + -1.0) * staticSwitch134_9);
    lowp vec4 tmpvar_20;
    mediump vec2 P_21;
    P_21 = (uv_SmokeShape_11 + tmpvar_19);
    tmpvar_20 = texture2D (_SmokeShape, P_21);
    tex2DNode122_8 = tmpvar_20;
    mediump float tmpvar_22;
    mediump float tmpvar_23;
    tmpvar_23 = clamp (((
      (1.0 - tex2DNode122_8.z)
     + 
      (-(max ((tmpvar_17 - _StartDispearTime), 0.0)) * _dispearSpeed)
    ) / 0.1), 0.0, 1.0);
    tmpvar_22 = (tmpvar_23 * (tmpvar_23 * (3.0 - 
      (2.0 * tmpvar_23)
    )));
    staticSwitch154_7 = 0.0;
    if ((_DiaPearByTime == 1.0)) {
      staticSwitch154_7 = (tex2DNode122_8.w * tmpvar_22);
    } else {
      staticSwitch154_7 = tex2DNode122_8.w;
    };
    highp vec2 tmpvar_24;
    tmpvar_24 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
    uv_TransparentNoise_6 = tmpvar_24;
    highp vec2 tmpvar_25;
    tmpvar_25 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
    uv_NoiseDistortion_5 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = mix (_DarkColor, _LightColor, tex2DNode122_8.xxxx);
    lerpResult142_4 = tmpvar_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = mix (lerpResult142_4, _RimColor, tex2DNode122_8.yyyy);
    lerpResult143_3 = tmpvar_27;
    lowp vec4 tmpvar_28;
    mediump vec2 P_29;
    P_29 = ((tmpvar_17 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_5);
    tmpvar_28 = texture2D (_NoiseDistortion, P_29);
    lowp vec4 tmpvar_30;
    mediump vec2 P_31;
    P_31 = ((tmpvar_19 + uv_TransparentNoise_6) + (tmpvar_28.x * _NoiseDistortionStrength));
    tmpvar_30 = texture2D (_TransparentNoise, P_31);
    mediump float tmpvar_32;
    highp float tmpvar_33;
    tmpvar_33 = clamp (((staticSwitch154_7 * tmpvar_30.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
    tmpvar_32 = tmpvar_33;
    highp vec3 tmpvar_34;
    tmpvar_34 = (xlv_COLOR * lerpResult143_3).xyz;
    aseOutColor_2 = tmpvar_34;
    mediump vec4 tmpvar_35;
    tmpvar_35.xyz = aseOutColor_2;
    tmpvar_35.w = clamp (tmpvar_32, 0.0, 1.0);
    tmpvar_1 = tmpvar_35;
  };
  gl_FragData[0] = tmpvar_1;
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 125191
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform highp float _MotionVectorDepthBias;
uniform highp mat4 _NonJitteredVP;
uniform highp mat4 _PreviousVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * tmpvar_3);
  tmpvar_2 = (unity_MatrixVP * tmpvar_4);
  tmpvar_2.z = (tmpvar_2.z + ((_MHYZBias + 
    (_MotionVectorDepthBias * 2.0)
  ) * tmpvar_2.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = (_NonJitteredVP * tmpvar_4);
  xlv_TEXCOORD4 = (_PreviousVP * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _MotionVectorsAlphaCutoff;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 velocity_2;
  mediump vec2 uvDiff_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  lowp vec4 tmpvar_25;
  mediump vec2 P_26;
  P_26 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_25 = texture2D (_NoiseDistortion, P_26);
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_25.x * _NoiseDistortionStrength));
  tmpvar_27 = texture2D (_TransparentNoise, P_28);
  mediump float tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((staticSwitch154_6 * tmpvar_27.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_29 = tmpvar_30;
  mediump float x_31;
  x_31 = (tmpvar_29 - _MotionVectorsAlphaCutoff);
  if ((x_31 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_32;
  tmpvar_32 = (((
    (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w)
  .xy + 1.0) / 2.0) - ((
    (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w)
  .xy + 1.0) / 2.0));
  uvDiff_3 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 1.0);
  tmpvar_33.xy = uvDiff_3;
  velocity_2.xy = tmpvar_33.xy;
  velocity_2.zw = vec2(0.0, 0.0);
  tmpvar_1 = velocity_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform highp float _MotionVectorDepthBias;
uniform highp mat4 _NonJitteredVP;
uniform highp mat4 _PreviousVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * tmpvar_3);
  tmpvar_2 = (unity_MatrixVP * tmpvar_4);
  tmpvar_2.z = (tmpvar_2.z + ((_MHYZBias + 
    (_MotionVectorDepthBias * 2.0)
  ) * tmpvar_2.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = (_NonJitteredVP * tmpvar_4);
  xlv_TEXCOORD4 = (_PreviousVP * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _MotionVectorsAlphaCutoff;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 velocity_2;
  mediump vec2 uvDiff_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  lowp vec4 tmpvar_25;
  mediump vec2 P_26;
  P_26 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_25 = texture2D (_NoiseDistortion, P_26);
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_25.x * _NoiseDistortionStrength));
  tmpvar_27 = texture2D (_TransparentNoise, P_28);
  mediump float tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((staticSwitch154_6 * tmpvar_27.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_29 = tmpvar_30;
  mediump float x_31;
  x_31 = (tmpvar_29 - _MotionVectorsAlphaCutoff);
  if ((x_31 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_32;
  tmpvar_32 = (((
    (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w)
  .xy + 1.0) / 2.0) - ((
    (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w)
  .xy + 1.0) / 2.0));
  uvDiff_3 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 1.0);
  tmpvar_33.xy = uvDiff_3;
  velocity_2.xy = tmpvar_33.xy;
  velocity_2.zw = vec2(0.0, 0.0);
  tmpvar_1 = velocity_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform highp float _MotionVectorDepthBias;
uniform highp mat4 _NonJitteredVP;
uniform highp mat4 _PreviousVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * tmpvar_3);
  tmpvar_2 = (unity_MatrixVP * tmpvar_4);
  tmpvar_2.z = (tmpvar_2.z + ((_MHYZBias + 
    (_MotionVectorDepthBias * 2.0)
  ) * tmpvar_2.w));
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = (_NonJitteredVP * tmpvar_4);
  xlv_TEXCOORD4 = (_PreviousVP * tmpvar_4);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _MotionVectorsAlphaCutoff;
uniform mediump float _DiaPearByTime;
uniform sampler2D _SmokeShape;
uniform highp vec4 _SmokeShape_ST;
uniform sampler2D _Distortion;
uniform mediump float _DistortWithTime;
uniform mediump float _DistortionStrength;
uniform mediump float _LoopTime;
uniform mediump float _StartDispearTime;
uniform mediump float _dispearSpeed;
uniform sampler2D _TransparentNoise;
uniform highp vec4 _TransparentNoise_ST;
uniform sampler2D _NoiseDistortion;
uniform mediump vec2 _NoiseDistortionSpeedXUspeedYVSpeed;
uniform highp vec4 _NoiseDistortion_ST;
uniform mediump float _NoiseDistortionStrength;
uniform mediump float _AlphaMuliplier;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 velocity_2;
  mediump vec2 uvDiff_3;
  mediump vec2 uv_NoiseDistortion_4;
  mediump vec2 uv_TransparentNoise_5;
  mediump float staticSwitch154_6;
  mediump vec4 tex2DNode122_7;
  mediump float staticSwitch134_8;
  mediump float mulTime131_9;
  mediump vec2 uv_SmokeShape_10;
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD0.xy * _SmokeShape_ST.xy) + _SmokeShape_ST.zw);
  uv_SmokeShape_10 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD0.xy * vec2(1.0, 2.0));
  highp float tmpvar_13;
  tmpvar_13 = _Time.y;
  mulTime131_9 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = (mulTime131_9 / _LoopTime);
  mediump float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _LoopTime);
  mediump float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  staticSwitch134_8 = 0.0;
  if ((_DistortWithTime == 1.0)) {
    staticSwitch134_8 = (_DistortionStrength * tmpvar_16);
  } else {
    staticSwitch134_8 = _DistortionStrength;
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_Distortion, tmpvar_12);
  mediump vec2 tmpvar_18;
  tmpvar_18 = (((tmpvar_17.xy * 2.0) + -1.0) * staticSwitch134_8);
  lowp vec4 tmpvar_19;
  mediump vec2 P_20;
  P_20 = (uv_SmokeShape_10 + tmpvar_18);
  tmpvar_19 = texture2D (_SmokeShape, P_20);
  tex2DNode122_7 = tmpvar_19;
  mediump float tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = clamp (((
    (1.0 - tex2DNode122_7.z)
   + 
    (-(max ((tmpvar_16 - _StartDispearTime), 0.0)) * _dispearSpeed)
  ) / 0.1), 0.0, 1.0);
  tmpvar_21 = (tmpvar_22 * (tmpvar_22 * (3.0 - 
    (2.0 * tmpvar_22)
  )));
  staticSwitch154_6 = 0.0;
  if ((_DiaPearByTime == 1.0)) {
    staticSwitch154_6 = (tex2DNode122_7.w * tmpvar_21);
  } else {
    staticSwitch154_6 = tex2DNode122_7.w;
  };
  highp vec2 tmpvar_23;
  tmpvar_23 = ((xlv_TEXCOORD0.xy * _TransparentNoise_ST.xy) + _TransparentNoise_ST.zw);
  uv_TransparentNoise_5 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0.xy * _NoiseDistortion_ST.xy) + _NoiseDistortion_ST.zw);
  uv_NoiseDistortion_4 = tmpvar_24;
  lowp vec4 tmpvar_25;
  mediump vec2 P_26;
  P_26 = ((tmpvar_16 * _NoiseDistortionSpeedXUspeedYVSpeed) + uv_NoiseDistortion_4);
  tmpvar_25 = texture2D (_NoiseDistortion, P_26);
  lowp vec4 tmpvar_27;
  mediump vec2 P_28;
  P_28 = ((tmpvar_18 + uv_TransparentNoise_5) + (tmpvar_25.x * _NoiseDistortionStrength));
  tmpvar_27 = texture2D (_TransparentNoise, P_28);
  mediump float tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((staticSwitch154_6 * tmpvar_27.x) * (_AlphaMuliplier * xlv_COLOR.w)), 0.0, 1.0);
  tmpvar_29 = tmpvar_30;
  mediump float x_31;
  x_31 = (tmpvar_29 - _MotionVectorsAlphaCutoff);
  if ((x_31 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_32;
  tmpvar_32 = (((
    (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w)
  .xy + 1.0) / 2.0) - ((
    (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w)
  .xy + 1.0) / 2.0));
  uvDiff_3 = tmpvar_32;
  mediump vec4 tmpvar_33;
  tmpvar_33.zw = vec2(0.0, 1.0);
  tmpvar_33.xy = uvDiff_3;
  velocity_2.xy = tmpvar_33.xy;
  velocity_2.zw = vec2(0.0, 0.0);
  tmpvar_1 = velocity_2;
  gl_FragData[0] = tmpvar_1;
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
CustomEditor "MiHoYoASEMaterialInspector"
}