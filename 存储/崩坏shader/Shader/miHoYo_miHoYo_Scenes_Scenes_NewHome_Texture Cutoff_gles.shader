//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Texture Cutoff" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 100
 Tags { "OutlineType" = "TransparentDualFace" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "OutlineType" = "TransparentDualFace" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 50510
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
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
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
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (_DitherAlpha * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
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
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
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
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (_DitherAlpha * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
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
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
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
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (_DitherAlpha * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
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
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
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
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (_DitherAlpha * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
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
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
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
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (_DitherAlpha * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
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
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
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
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (_DitherAlpha * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
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
}
}