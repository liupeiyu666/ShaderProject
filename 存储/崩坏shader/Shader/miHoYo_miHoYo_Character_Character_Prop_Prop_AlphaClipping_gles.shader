//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_AlphaClipping" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_AlphaClip ("Alpha Clip", Float) = 0.01
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "OutlineType" = "NoneAlphaClip" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "NoneAlphaClip" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 38705
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(0.0, 0.0, 0.0, 0.0);
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
  xlv_COLOR = _MainColor;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _AlphaClip;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1 = (tmpvar_2 * xlv_COLOR);
  outColor_1.xyz = (outColor_1.xyz * _EnvColor.xyz);
  mediump float x_3;
  x_3 = (outColor_1.w - _AlphaClip);
  if ((x_3 < 0.0)) {
    discard;
  };
  outColor_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = xlv_TEXCOORD1.z;
    if ((a_5 < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (a_5 * 17.0);
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
  gl_FragData[0] = outColor_1;
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
uniform mediump vec4 _MainColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(0.0, 0.0, 0.0, 0.0);
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
  xlv_COLOR = _MainColor;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _AlphaClip;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1 = (tmpvar_2 * xlv_COLOR);
  outColor_1.xyz = (outColor_1.xyz * _EnvColor.xyz);
  mediump float x_3;
  x_3 = (outColor_1.w - _AlphaClip);
  if ((x_3 < 0.0)) {
    discard;
  };
  outColor_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = xlv_TEXCOORD1.z;
    if ((a_5 < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (a_5 * 17.0);
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
  gl_FragData[0] = outColor_1;
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
uniform mediump vec4 _MainColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(0.0, 0.0, 0.0, 0.0);
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
  xlv_COLOR = _MainColor;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _AlphaClip;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1 = (tmpvar_2 * xlv_COLOR);
  outColor_1.xyz = (outColor_1.xyz * _EnvColor.xyz);
  mediump float x_3;
  x_3 = (outColor_1.w - _AlphaClip);
  if ((x_3 < 0.0)) {
    discard;
  };
  outColor_1.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD1;
    mediump float a_5;
    a_5 = xlv_TEXCOORD1.z;
    if ((a_5 < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w) * _ScreenParams.xy);
      a_5 = (a_5 * 17.0);
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
  gl_FragData[0] = outColor_1;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}