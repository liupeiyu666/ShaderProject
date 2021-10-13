//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Lightmap Dither Clip" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "OutlineType" = "None" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 42615
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  outColor_4.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (_DitherAlpha * 17.0);
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
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  outColor_4.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (_DitherAlpha * 17.0);
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
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  outColor_4.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (_DitherAlpha * 17.0);
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
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  outColor_4.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (_DitherAlpha * 17.0);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, vec3(dot (colorBlendLightMap_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  outColor_4.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (_DitherAlpha * 17.0);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, vec3(dot (colorBlendLightMap_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  outColor_4.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD2;
    mediump float a_8;
    a_8 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_8 = (_DitherAlpha * 17.0);
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
  outColor_4.xyz = mix (colorBlendLightMap_1, vec3(dot (colorBlendLightMap_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
Fallback "Diffuse"
}