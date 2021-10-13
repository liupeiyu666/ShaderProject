//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Special/MusicSymbols" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_Emission ("Emission", Range(1, 10)) = 1
_EmissionColor ("Emmisive Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_UVYScale ("UV Y Scale", Range(0.1, 10)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  ZWrite Off
  Offset -2, -2
  GpuProgramID 8370
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_5;
    highp vec4 tmpvar_6;
    tmpvar_6 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_7;
    tmpvar_7.x = tmpvar_6.x;
    tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
    o_5.xy = (tmpvar_7 + tmpvar_6.w);
    o_5.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_5.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _UVYScale;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1.x = xlv_TEXCOORD0.x;
  mediump vec4 col_2;
  tmpvar_1.y = (xlv_TEXCOORD0.y / (_UVYScale + 0.0001));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (col_2.w - 0.1);
  if ((x_4 < 0.0)) {
    discard;
  };
  col_2.xyz = (col_2.xyz * (_Emission * _EmissionColor).xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_5;
    scrpos_5 = xlv_TEXCOORD1;
    mediump float a_6;
    a_6 = xlv_TEXCOORD1.z;
    if ((a_6 < 0.95)) {
      scrpos_5.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_6 = (a_6 * 17.0);
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_5.y / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float tmpvar_10;
      tmpvar_10 = (scrpos_5.x / 4.0);
      highp float tmpvar_11;
      tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
      highp float tmpvar_12;
      if ((tmpvar_10 >= 0.0)) {
        tmpvar_12 = tmpvar_11;
      } else {
        tmpvar_12 = -(tmpvar_11);
      };
      highp float x_13;
      x_13 = ((a_6 - _DITHERMATRIX[
        int(tmpvar_9)
      ][
        int(tmpvar_12)
      ]) - 0.01);
      if ((x_13 < 0.0)) {
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_5;
    highp vec4 tmpvar_6;
    tmpvar_6 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_7;
    tmpvar_7.x = tmpvar_6.x;
    tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
    o_5.xy = (tmpvar_7 + tmpvar_6.w);
    o_5.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_5.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _UVYScale;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1.x = xlv_TEXCOORD0.x;
  mediump vec4 col_2;
  tmpvar_1.y = (xlv_TEXCOORD0.y / (_UVYScale + 0.0001));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (col_2.w - 0.1);
  if ((x_4 < 0.0)) {
    discard;
  };
  col_2.xyz = (col_2.xyz * (_Emission * _EmissionColor).xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_5;
    scrpos_5 = xlv_TEXCOORD1;
    mediump float a_6;
    a_6 = xlv_TEXCOORD1.z;
    if ((a_6 < 0.95)) {
      scrpos_5.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_6 = (a_6 * 17.0);
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_5.y / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float tmpvar_10;
      tmpvar_10 = (scrpos_5.x / 4.0);
      highp float tmpvar_11;
      tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
      highp float tmpvar_12;
      if ((tmpvar_10 >= 0.0)) {
        tmpvar_12 = tmpvar_11;
      } else {
        tmpvar_12 = -(tmpvar_11);
      };
      highp float x_13;
      x_13 = ((a_6 - _DITHERMATRIX[
        int(tmpvar_9)
      ][
        int(tmpvar_12)
      ]) - 0.01);
      if ((x_13 < 0.0)) {
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_5;
    highp vec4 tmpvar_6;
    tmpvar_6 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_7;
    tmpvar_7.x = tmpvar_6.x;
    tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
    o_5.xy = (tmpvar_7 + tmpvar_6.w);
    o_5.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_5.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump float _Emission;
uniform mediump vec4 _EmissionColor;
uniform mediump float _UVYScale;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1.x = xlv_TEXCOORD0.x;
  mediump vec4 col_2;
  tmpvar_1.y = (xlv_TEXCOORD0.y / (_UVYScale + 0.0001));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (col_2.w - 0.1);
  if ((x_4 < 0.0)) {
    discard;
  };
  col_2.xyz = (col_2.xyz * (_Emission * _EmissionColor).xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_5;
    scrpos_5 = xlv_TEXCOORD1;
    mediump float a_6;
    a_6 = xlv_TEXCOORD1.z;
    if ((a_6 < 0.95)) {
      scrpos_5.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_6 = (a_6 * 17.0);
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_5.y / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float tmpvar_10;
      tmpvar_10 = (scrpos_5.x / 4.0);
      highp float tmpvar_11;
      tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
      highp float tmpvar_12;
      if ((tmpvar_10 >= 0.0)) {
        tmpvar_12 = tmpvar_11;
      } else {
        tmpvar_12 = -(tmpvar_11);
      };
      highp float x_13;
      x_13 = ((a_6 - _DITHERMATRIX[
        int(tmpvar_9)
      ][
        int(tmpvar_12)
      ]) - 0.01);
      if ((x_13 < 0.0)) {
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
}
}
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+10" "RenderType" = "Opaque" }
  ZTest Equal
  ZWrite Off
  GpuProgramID 71243
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_5;
    highp vec4 tmpvar_6;
    tmpvar_6 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_7;
    tmpvar_7.x = tmpvar_6.x;
    tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
    o_5.xy = (tmpvar_7 + tmpvar_6.w);
    o_5.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_5.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _UVYScale;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1.x = xlv_TEXCOORD0.x;
  mediump vec4 col_2;
  tmpvar_1.y = (xlv_TEXCOORD0.y / (_UVYScale + 0.0001));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (col_2.w - 0.1);
  if ((x_4 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(_BloomFactor);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_5;
    highp vec4 tmpvar_6;
    tmpvar_6 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_7;
    tmpvar_7.x = tmpvar_6.x;
    tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
    o_5.xy = (tmpvar_7 + tmpvar_6.w);
    o_5.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_5.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _UVYScale;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1.x = xlv_TEXCOORD0.x;
  mediump vec4 col_2;
  tmpvar_1.y = (xlv_TEXCOORD0.y / (_UVYScale + 0.0001));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (col_2.w - 0.1);
  if ((x_4 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(_BloomFactor);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_5;
    highp vec4 tmpvar_6;
    tmpvar_6 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_7;
    tmpvar_7.x = tmpvar_6.x;
    tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
    o_5.xy = (tmpvar_7 + tmpvar_6.w);
    o_5.zw = tmpvar_3.zw;
    tmpvar_2.xyw = o_5.xyw;
    tmpvar_2.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _UVYScale;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1.x = xlv_TEXCOORD0.x;
  mediump vec4 col_2;
  tmpvar_1.y = (xlv_TEXCOORD0.y / (_UVYScale + 0.0001));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_1);
  col_2 = tmpvar_3;
  mediump float x_4;
  x_4 = (col_2.w - 0.1);
  if ((x_4 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(_BloomFactor);
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