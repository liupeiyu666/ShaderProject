//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Texture Dither Outline" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
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
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 17775
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_6;
    highp vec4 tmpvar_7;
    tmpvar_7 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_8;
    tmpvar_8.x = tmpvar_7.x;
    tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
    o_6.xy = (tmpvar_8 + tmpvar_7.w);
    o_6.zw = tmpvar_4.zw;
    tmpvar_3 = o_6;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD2;
    mediump float a_4;
    a_4 = _DitherAlpha;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
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
  gl_FragData[0] = col_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_6;
    highp vec4 tmpvar_7;
    tmpvar_7 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_8;
    tmpvar_8.x = tmpvar_7.x;
    tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
    o_6.xy = (tmpvar_8 + tmpvar_7.w);
    o_6.zw = tmpvar_4.zw;
    tmpvar_3 = o_6;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD2;
    mediump float a_4;
    a_4 = _DitherAlpha;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
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
  gl_FragData[0] = col_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_6;
    highp vec4 tmpvar_7;
    tmpvar_7 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_8;
    tmpvar_8.x = tmpvar_7.x;
    tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
    o_6.xy = (tmpvar_8 + tmpvar_7.w);
    o_6.zw = tmpvar_4.zw;
    tmpvar_3 = o_6;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD2;
    mediump float a_4;
    a_4 = _DitherAlpha;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
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
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_6;
    highp vec4 tmpvar_7;
    tmpvar_7 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_8;
    tmpvar_8.x = tmpvar_7.x;
    tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
    o_6.xy = (tmpvar_8 + tmpvar_7.w);
    o_6.zw = tmpvar_4.zw;
    tmpvar_3 = o_6;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD2;
    mediump float a_4;
    a_4 = _DitherAlpha;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
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
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_6;
    highp vec4 tmpvar_7;
    tmpvar_7 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_8;
    tmpvar_8.x = tmpvar_7.x;
    tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
    o_6.xy = (tmpvar_8 + tmpvar_7.w);
    o_6.zw = tmpvar_4.zw;
    tmpvar_3 = o_6;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD2;
    mediump float a_4;
    a_4 = _DitherAlpha;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
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
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor.xyz;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_6;
    highp vec4 tmpvar_7;
    tmpvar_7 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_8;
    tmpvar_8.x = tmpvar_7.x;
    tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
    o_6.xy = (tmpvar_8 + tmpvar_7.w);
    o_6.zw = tmpvar_4.zw;
    tmpvar_3 = o_6;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = tmpvar_2.xyz;
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD2;
    mediump float a_4;
    a_4 = _DitherAlpha;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
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
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
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
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 100
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 77946
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