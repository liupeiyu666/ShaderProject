//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Texture Dither Outline AO" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_ClipPlane ("Clip Plane (Model Space)", Vector) = (0,0,0,0)
[Toggle] _UseCameraFade ("Use Camera Fade", Float) = 0
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 0
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_AOColor ("AO Color (RGB) Intensity (A)", Color) = (0.2,0.2,0.2,1)
_AOTex ("AO Texture", 2D) = "white" { }
_AOMask ("AO Mask (X: Left, Y: Right, Z: Front, W: Back)", Vector) = (0,0,0,0)
[Toggle(ENABLE_REFLECTION)] _EnableReflection ("Enable Reflection", Float) = 0
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 16989
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  tmpvar_4 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_8;
    highp vec4 tmpvar_9;
    tmpvar_9 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_10;
    tmpvar_10.x = tmpvar_9.x;
    tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
    o_8.xy = (tmpvar_10 + tmpvar_9.w);
    o_8.zw = tmpvar_6.zw;
    tmpvar_5 = o_8;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump vec4 _AOColor;
uniform sampler2D _AOTex;
uniform mediump vec4 _AOMask;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 aoPack_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTex, xlv_TEXCOORD1);
  aoPack_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((1.0 - aoPack_1) * _AOMask);
  mediump float tmpvar_6;
  tmpvar_6 = max (max (max (tmpvar_5.x, tmpvar_5.y), max (tmpvar_5.z, tmpvar_5.w)), (1.0 - max (
    max (aoPack_1.x, aoPack_1.y)
  , 
    max (aoPack_1.z, aoPack_1.w)
  )));
  col_2.xyz = (((col_2.xyz * _AOColor.xyz) * clamp (
    (tmpvar_6 * _AOColor.w)
  , 0.0, 1.0)) + (col_2.xyz * (1.0 - 
    clamp ((tmpvar_6 * _AOColor.w), 0.0, 1.0)
  )));
  col_2.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  tmpvar_4 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_8;
    highp vec4 tmpvar_9;
    tmpvar_9 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_10;
    tmpvar_10.x = tmpvar_9.x;
    tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
    o_8.xy = (tmpvar_10 + tmpvar_9.w);
    o_8.zw = tmpvar_6.zw;
    tmpvar_5 = o_8;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump vec4 _AOColor;
uniform sampler2D _AOTex;
uniform mediump vec4 _AOMask;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 aoPack_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTex, xlv_TEXCOORD1);
  aoPack_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((1.0 - aoPack_1) * _AOMask);
  mediump float tmpvar_6;
  tmpvar_6 = max (max (max (tmpvar_5.x, tmpvar_5.y), max (tmpvar_5.z, tmpvar_5.w)), (1.0 - max (
    max (aoPack_1.x, aoPack_1.y)
  , 
    max (aoPack_1.z, aoPack_1.w)
  )));
  col_2.xyz = (((col_2.xyz * _AOColor.xyz) * clamp (
    (tmpvar_6 * _AOColor.w)
  , 0.0, 1.0)) + (col_2.xyz * (1.0 - 
    clamp ((tmpvar_6 * _AOColor.w), 0.0, 1.0)
  )));
  col_2.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = tmpvar_1;
  tmpvar_4 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_8;
    highp vec4 tmpvar_9;
    tmpvar_9 = (tmpvar_6 * 0.5);
    highp vec2 tmpvar_10;
    tmpvar_10.x = tmpvar_9.x;
    tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
    o_8.xy = (tmpvar_10 + tmpvar_9.w);
    o_8.zw = tmpvar_6.zw;
    tmpvar_5 = o_8;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump vec4 _AOColor;
uniform sampler2D _AOTex;
uniform mediump vec4 _AOMask;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 aoPack_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTex, xlv_TEXCOORD1);
  aoPack_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((1.0 - aoPack_1) * _AOMask);
  mediump float tmpvar_6;
  tmpvar_6 = max (max (max (tmpvar_5.x, tmpvar_5.y), max (tmpvar_5.z, tmpvar_5.w)), (1.0 - max (
    max (aoPack_1.x, aoPack_1.y)
  , 
    max (aoPack_1.z, aoPack_1.w)
  )));
  col_2.xyz = (((col_2.xyz * _AOColor.xyz) * clamp (
    (tmpvar_6 * _AOColor.w)
  , 0.0, 1.0)) + (col_2.xyz * (1.0 - 
    clamp ((tmpvar_6 * _AOColor.w), 0.0, 1.0)
  )));
  col_2.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (a_8 * 17.0);
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_7.y / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float tmpvar_12;
      tmpvar_12 = (scrpos_7.x / 4.0);
      highp float tmpvar_13;
      tmpvar_13 = (fract(abs(tmpvar_12)) * 4.0);
      highp float tmpvar_14;
      if ((tmpvar_12 >= 0.0)) {
        tmpvar_14 = tmpvar_13;
      } else {
        tmpvar_14 = -(tmpvar_13);
      };
      highp float x_15;
      x_15 = ((a_8 - _DITHERMATRIX[
        int(tmpvar_11)
      ][
        int(tmpvar_14)
      ]) - 0.01);
      if ((x_15 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ENABLE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = tmpvar_1;
  tmpvar_8 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_14;
    highp vec4 tmpvar_15;
    tmpvar_15 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_16;
    tmpvar_16.x = tmpvar_15.x;
    tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
    o_14.xy = (tmpvar_16 + tmpvar_15.w);
    o_14.zw = tmpvar_12.zw;
    tmpvar_9 = o_14;
  };
  tmpvar_10 = tmpvar_2;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_17.xz - ((tmpvar_17.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = cos(_CamRotate);
  cost_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = sin(_CamRotate);
  sint_3 = tmpvar_20;
  highp mat2 tmpvar_21;
  tmpvar_21[0].x = cost_4;
  tmpvar_21[0].y = -(sint_3);
  tmpvar_21[1].x = sint_3;
  tmpvar_21[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_21 * tmpvar_11.xz);
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump vec4 _AOColor;
uniform sampler2D _AOTex;
uniform mediump vec4 _AOMask;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 aoPack_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTex, xlv_TEXCOORD1);
  aoPack_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((1.0 - aoPack_1) * _AOMask);
  mediump float tmpvar_6;
  tmpvar_6 = max (max (max (tmpvar_5.x, tmpvar_5.y), max (tmpvar_5.z, tmpvar_5.w)), (1.0 - max (
    max (aoPack_1.x, aoPack_1.y)
  , 
    max (aoPack_1.z, aoPack_1.w)
  )));
  col_2.xyz = (((col_2.xyz * _AOColor.xyz) * clamp (
    (tmpvar_6 * _AOColor.w)
  , 0.0, 1.0)) + (col_2.xyz * (1.0 - 
    clamp ((tmpvar_6 * _AOColor.w), 0.0, 1.0)
  )));
  mediump vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4 - (2.0 * (
    dot (xlv_TEXCOORD3, xlv_TEXCOORD4)
   * xlv_TEXCOORD3)));
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureCube (_EnvTex, tmpvar_7);
  col_2.xyz = (col_2.xyz + ((tmpvar_8.xyz * col_2.w) * _Reflectivity));
  col_2.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = _DitherAlpha;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ENABLE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = tmpvar_1;
  tmpvar_8 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_14;
    highp vec4 tmpvar_15;
    tmpvar_15 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_16;
    tmpvar_16.x = tmpvar_15.x;
    tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
    o_14.xy = (tmpvar_16 + tmpvar_15.w);
    o_14.zw = tmpvar_12.zw;
    tmpvar_9 = o_14;
  };
  tmpvar_10 = tmpvar_2;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_17.xz - ((tmpvar_17.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = cos(_CamRotate);
  cost_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = sin(_CamRotate);
  sint_3 = tmpvar_20;
  highp mat2 tmpvar_21;
  tmpvar_21[0].x = cost_4;
  tmpvar_21[0].y = -(sint_3);
  tmpvar_21[1].x = sint_3;
  tmpvar_21[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_21 * tmpvar_11.xz);
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump vec4 _AOColor;
uniform sampler2D _AOTex;
uniform mediump vec4 _AOMask;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 aoPack_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTex, xlv_TEXCOORD1);
  aoPack_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((1.0 - aoPack_1) * _AOMask);
  mediump float tmpvar_6;
  tmpvar_6 = max (max (max (tmpvar_5.x, tmpvar_5.y), max (tmpvar_5.z, tmpvar_5.w)), (1.0 - max (
    max (aoPack_1.x, aoPack_1.y)
  , 
    max (aoPack_1.z, aoPack_1.w)
  )));
  col_2.xyz = (((col_2.xyz * _AOColor.xyz) * clamp (
    (tmpvar_6 * _AOColor.w)
  , 0.0, 1.0)) + (col_2.xyz * (1.0 - 
    clamp ((tmpvar_6 * _AOColor.w), 0.0, 1.0)
  )));
  mediump vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4 - (2.0 * (
    dot (xlv_TEXCOORD3, xlv_TEXCOORD4)
   * xlv_TEXCOORD3)));
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureCube (_EnvTex, tmpvar_7);
  col_2.xyz = (col_2.xyz + ((tmpvar_8.xyz * col_2.w) * _Reflectivity));
  col_2.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = _DitherAlpha;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ENABLE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec3 tmpvar_2;
  tmpvar_2 = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  mediump vec3 tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_10 = vec3(0.0, 0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_7 = tmpvar_1;
  tmpvar_8 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_14;
    highp vec4 tmpvar_15;
    tmpvar_15 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_16;
    tmpvar_16.x = tmpvar_15.x;
    tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
    o_14.xy = (tmpvar_16 + tmpvar_15.w);
    o_14.zw = tmpvar_12.zw;
    tmpvar_9 = o_14;
  };
  tmpvar_10 = tmpvar_2;
  highp vec4 tmpvar_17;
  tmpvar_17 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_17.xz - ((tmpvar_17.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = cos(_CamRotate);
  cost_4 = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = sin(_CamRotate);
  sint_3 = tmpvar_20;
  highp mat2 tmpvar_21;
  tmpvar_21[0].x = cost_4;
  tmpvar_21[0].y = -(sint_3);
  tmpvar_21[1].x = sint_3;
  tmpvar_21[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_21 * tmpvar_11.xz);
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump vec4 _AOColor;
uniform sampler2D _AOTex;
uniform mediump vec4 _AOMask;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 aoPack_1;
  mediump vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTex, xlv_TEXCOORD1);
  aoPack_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((1.0 - aoPack_1) * _AOMask);
  mediump float tmpvar_6;
  tmpvar_6 = max (max (max (tmpvar_5.x, tmpvar_5.y), max (tmpvar_5.z, tmpvar_5.w)), (1.0 - max (
    max (aoPack_1.x, aoPack_1.y)
  , 
    max (aoPack_1.z, aoPack_1.w)
  )));
  col_2.xyz = (((col_2.xyz * _AOColor.xyz) * clamp (
    (tmpvar_6 * _AOColor.w)
  , 0.0, 1.0)) + (col_2.xyz * (1.0 - 
    clamp ((tmpvar_6 * _AOColor.w), 0.0, 1.0)
  )));
  mediump vec3 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD4 - (2.0 * (
    dot (xlv_TEXCOORD3, xlv_TEXCOORD4)
   * xlv_TEXCOORD3)));
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureCube (_EnvTex, tmpvar_7);
  col_2.xyz = (col_2.xyz + ((tmpvar_8.xyz * col_2.w) * _Reflectivity));
  col_2.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_9;
    scrpos_9 = xlv_TEXCOORD2;
    mediump float a_10;
    a_10 = _DitherAlpha;
    if ((a_10 < 0.95)) {
      scrpos_9.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_10 = (a_10 * 17.0);
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_9.y / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float tmpvar_14;
      tmpvar_14 = (scrpos_9.x / 4.0);
      highp float tmpvar_15;
      tmpvar_15 = (fract(abs(tmpvar_14)) * 4.0);
      highp float tmpvar_16;
      if ((tmpvar_14 >= 0.0)) {
        tmpvar_16 = tmpvar_15;
      } else {
        tmpvar_16 = -(tmpvar_15);
      };
      highp float x_17;
      x_17 = ((a_10 - _DITHERMATRIX[
        int(tmpvar_13)
      ][
        int(tmpvar_16)
      ]) - 0.01);
      if ((x_17 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_2;
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
Keywords { "ENABLE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ENABLE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ENABLE_REFLECTION" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 100
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 119336
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = (unity_MatrixMV * _glesVertex);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  tmpvar_5 = _OutlineColor;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_7;
    fadeOffset_7 = _FadeOffset;
    highp float fadeDistance_8;
    fadeDistance_8 = _FadeDistance;
    highp float tmpvar_9;
    tmpvar_9 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
    tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  };
  tmpvar_5.w = (tmpvar_5.w * _Opaqueness);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixMV[0].xyz;
  tmpvar_15[1] = unity_MatrixMV[1].xyz;
  tmpvar_15[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_16.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(N_2);
  N_2 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_18));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_17.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = (unity_MatrixMV * _glesVertex);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  tmpvar_5 = _OutlineColor;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_7;
    fadeOffset_7 = _FadeOffset;
    highp float fadeDistance_8;
    fadeDistance_8 = _FadeDistance;
    highp float tmpvar_9;
    tmpvar_9 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
    tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  };
  tmpvar_5.w = (tmpvar_5.w * _Opaqueness);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixMV[0].xyz;
  tmpvar_15[1] = unity_MatrixMV[1].xyz;
  tmpvar_15[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_16.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(N_2);
  N_2 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_18));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_17.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = (unity_MatrixMV * _glesVertex);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  tmpvar_5 = _OutlineColor;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_7;
    fadeOffset_7 = _FadeOffset;
    highp float fadeDistance_8;
    fadeDistance_8 = _FadeDistance;
    highp float tmpvar_9;
    tmpvar_9 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
    tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  };
  tmpvar_5.w = (tmpvar_5.w * _Opaqueness);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_MatrixMV[0].xyz;
  tmpvar_15[1] = unity_MatrixMV[1].xyz;
  tmpvar_15[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_16.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_17;
  tmpvar_17 = normalize(N_2);
  N_2 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_18));
  tmpvar_4.xyz = (tmpvar_4.xyz + ((
    (normalize(tmpvar_4.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_17.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
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