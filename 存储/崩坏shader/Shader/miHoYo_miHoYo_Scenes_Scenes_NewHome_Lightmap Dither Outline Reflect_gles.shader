//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Lightmap Dither Outline Reflect" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_ReflectionTex ("Reflection", 2D) = "white" { }
_ReflectionEmissionAdjust ("Reflection Emission Adjust", Float) = 1
_FresnelParams ("Fresnel Parameters", Vector) = (1,1,0,0)
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
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
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 49511
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
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
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform highp vec4 _FresnelParams;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec3 I_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_S_Color_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_4 = tmpvar_8;
  colorBlendLightMap_3 = ((tex_C_Color_5.xyz * (
    (((2.0 * tex_S_Color_4.xyz) * tex_S_Color_4.w) + 1.0)
   - tex_S_Color_4.w)) * _LightMapIntensity);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_2 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectionTex, tmpvar_13);
  reflColor_1 = tmpvar_14;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * tex_C_Color_5.w);
  outColor_6.xyz = mix (colorBlendLightMap_3, reflColor_1.xyz, vec3((bias_12 + max (0.0, 
    (pow (clamp ((1.0 - 
      dot (I_2, xlv_TEXCOORD4)
    ), 0.001, 1.0), power_10) * scale_11)
  ))));
  outColor_6.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (_DitherAlpha * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform highp vec4 _FresnelParams;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec3 I_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_S_Color_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_4 = tmpvar_8;
  colorBlendLightMap_3 = ((tex_C_Color_5.xyz * (
    (((2.0 * tex_S_Color_4.xyz) * tex_S_Color_4.w) + 1.0)
   - tex_S_Color_4.w)) * _LightMapIntensity);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_2 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectionTex, tmpvar_13);
  reflColor_1 = tmpvar_14;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * tex_C_Color_5.w);
  outColor_6.xyz = mix (colorBlendLightMap_3, reflColor_1.xyz, vec3((bias_12 + max (0.0, 
    (pow (clamp ((1.0 - 
      dot (I_2, xlv_TEXCOORD4)
    ), 0.001, 1.0), power_10) * scale_11)
  ))));
  outColor_6.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (_DitherAlpha * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform highp vec4 _FresnelParams;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec3 I_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_S_Color_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_4 = tmpvar_8;
  colorBlendLightMap_3 = ((tex_C_Color_5.xyz * (
    (((2.0 * tex_S_Color_4.xyz) * tex_S_Color_4.w) + 1.0)
   - tex_S_Color_4.w)) * _LightMapIntensity);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_2 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectionTex, tmpvar_13);
  reflColor_1 = tmpvar_14;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * tex_C_Color_5.w);
  outColor_6.xyz = mix (colorBlendLightMap_3, reflColor_1.xyz, vec3((bias_12 + max (0.0, 
    (pow (clamp ((1.0 - 
      dot (I_2, xlv_TEXCOORD4)
    ), 0.001, 1.0), power_10) * scale_11)
  ))));
  outColor_6.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (_DitherAlpha * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
uniform highp vec4 _FresnelParams;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec3 I_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_S_Color_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_4 = tmpvar_8;
  colorBlendLightMap_3 = ((tex_C_Color_5.xyz * (
    (((2.0 * tex_S_Color_4.xyz) * tex_S_Color_4.w) + 1.0)
   - tex_S_Color_4.w)) * _LightMapIntensity);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_2 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectionTex, tmpvar_13);
  reflColor_1 = tmpvar_14;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * tex_C_Color_5.w);
  outColor_6.xyz = mix (colorBlendLightMap_3, reflColor_1.xyz, vec3((bias_12 + max (0.0, 
    (pow (clamp ((1.0 - 
      dot (I_2, xlv_TEXCOORD4)
    ), 0.001, 1.0), power_10) * scale_11)
  ))));
  outColor_6.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (_DitherAlpha * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
uniform highp vec4 _FresnelParams;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec3 I_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_S_Color_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_4 = tmpvar_8;
  colorBlendLightMap_3 = ((tex_C_Color_5.xyz * (
    (((2.0 * tex_S_Color_4.xyz) * tex_S_Color_4.w) + 1.0)
   - tex_S_Color_4.w)) * _LightMapIntensity);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_2 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectionTex, tmpvar_13);
  reflColor_1 = tmpvar_14;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * tex_C_Color_5.w);
  outColor_6.xyz = mix (colorBlendLightMap_3, reflColor_1.xyz, vec3((bias_12 + max (0.0, 
    (pow (clamp ((1.0 - 
      dot (I_2, xlv_TEXCOORD4)
    ), 0.001, 1.0), power_10) * scale_11)
  ))));
  outColor_6.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (_DitherAlpha * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  tmpvar_4 = tmpvar_12;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_13;
    highp vec4 tmpvar_14;
    tmpvar_14 = (tmpvar_5 * 0.5);
    highp vec2 tmpvar_15;
    tmpvar_15.x = tmpvar_14.x;
    tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
    o_13.xy = (tmpvar_15 + tmpvar_14.w);
    o_13.zw = tmpvar_5.zw;
    tmpvar_3 = o_13;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
uniform mediump float _LumiFactor;
uniform highp vec4 _FresnelParams;
uniform sampler2D _ReflectionTex;
uniform mediump float _ReflectionEmissionAdjust;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 reflColor_1;
  mediump vec3 I_2;
  mediump vec3 colorBlendLightMap_3;
  mediump vec4 tex_S_Color_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_4 = tmpvar_8;
  colorBlendLightMap_3 = ((tex_C_Color_5.xyz * (
    (((2.0 * tex_S_Color_4.xyz) * tex_S_Color_4.w) + 1.0)
   - tex_S_Color_4.w)) * _LightMapIntensity);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  I_2 = tmpvar_9;
  mediump float power_10;
  power_10 = _FresnelParams.x;
  mediump float scale_11;
  scale_11 = _FresnelParams.y;
  mediump float bias_12;
  bias_12 = _FresnelParams.z;
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_ReflectionTex, tmpvar_13);
  reflColor_1 = tmpvar_14;
  reflColor_1.xyz = (reflColor_1.xyz * _ReflectionEmissionAdjust);
  reflColor_1.xyz = (reflColor_1.xyz * tex_C_Color_5.w);
  outColor_6.xyz = mix (colorBlendLightMap_3, reflColor_1.xyz, vec3((bias_12 + max (0.0, 
    (pow (clamp ((1.0 - 
      dot (I_2, xlv_TEXCOORD4)
    ), 0.001, 1.0), power_10) * scale_11)
  ))));
  outColor_6.w = _BloomFactor;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD2;
    mediump float a_16;
    a_16 = _DitherAlpha;
    if ((_DitherAlpha < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_16 = (_DitherAlpha * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_6;
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
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_USE_REFLECTION" }
""
}
}
}
 UsePass "miHoYo/miHoYo_Scenes/Scenes_NewHome/Texture Dither Outline/COMPLEX"
}
Fallback "Diffuse"
}