//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Special/ThinFilm_Wing" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_FringeTex ("Fringe Tex (RGB)", 2D) = "white" { }
_FringeBumpTex ("Frige Bump Tex", 2D) = "gray" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_MinAlpha ("Min Alpha", Range(0, 1)) = 0
_OpaquenessScalerWithoutHDR ("", Float) = 1
_EmissionScaler ("Emission Scaler", Range(1, 20)) = 1
_EmissionScalerScalerWithoutHDR ("", Float) = 1
_FringeIntensity ("Fringe Intensity", Range(0, 10)) = 1
_FringeBumpScaler ("Fringe Bump Scaler", Range(0, 10)) = 1
_FringeRangeScaler ("Fringe Range Scaler", Range(0, 10)) = 1
_FringeRangeOffset ("Fringe Range Offset", Range(0, 1)) = 0
_FringeViewDistance ("Fringe View Distance", Float) = 5
_FringeFresnel ("Fringe Fresnel", Vector) = (1,1,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 15950
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FringeBumpTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _FringeViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _FringeBumpTex_ST.xy) + _FringeBumpTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _FringeViewDistance));
  adjCamPos_1 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((adjCamPos_1 - (unity_ObjectToWorld * _glesVertex).xyz));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = -(normalize((_glesNormal * tmpvar_14)));
  highp vec3 tmpvar_15;
  tmpvar_15.z = 0.0;
  tmpvar_15.x = tmpvar_5.y;
  tmpvar_15.y = -(tmpvar_5.x);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_15);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((tmpvar_5.yzx * tmpvar_16.zxy) - (tmpvar_5.zxy * tmpvar_16.yzx)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_12.zw;
    tmpvar_7.xyw = o_18.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD3 = tmpvar_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _FringeBumpTex;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _FringeTex;
uniform highp float _FringeIntensity;
uniform highp float _FringeBumpScaler;
uniform highp float _FringeRangeScaler;
uniform highp float _FringeRangeOffset;
uniform mediump vec4 _FringeFresnel;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 fringeColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  highp vec3 bumpVector_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz;
  baseTexColor_6 = tmpvar_8;
  outColor_7.xyz = ((baseTexColor_6 * _Color.xyz) * _EnvColor.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (texture2D (_FringeBumpTex, xlv_TEXCOORD0.zw).xyz - vec3(0.5, 0.5, 0.0));
  bumpVector_5 = tmpvar_9;
  bumpVector_5.xy = (bumpVector_5.xy * _FringeBumpScaler);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(bumpVector_5);
  bumpVector_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = abs(dot ((
    ((xlv_TEXCOORD2 * tmpvar_10.x) + (xlv_TEXCOORD3 * tmpvar_10.y))
   + 
    (xlv_TEXCOORD4 * tmpvar_10.z)
  ), normalize(xlv_TEXCOORD1)));
  cs_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(((tmpvar_12 * _FringeRangeScaler) + _FringeRangeOffset));
  uv_3 = tmpvar_13;
  highp float tmpvar_14;
  highp float cs_15;
  cs_15 = cs_4;
  highp float power_16;
  power_16 = _FringeFresnel.x;
  highp float scale_17;
  scale_17 = _FringeFresnel.y;
  highp float bias_18;
  bias_18 = _FringeFresnel.z;
  tmpvar_14 = (bias_18 + (pow (
    clamp ((1.0 - cs_15), 0.0, 1.0)
  , power_16) * scale_17));
  f_2 = tmpvar_14;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FringeTex, uv_3);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_19 * _FringeIntensity) * f_2) * (tmpvar_10.y + 0.5)).xyz;
  fringeColor_1 = tmpvar_20;
  outColor_7.xyz = ((outColor_7.xyz + fringeColor_1) - (outColor_7.xyz * fringeColor_1));
  outColor_7.xyz = (outColor_7.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  highp float tmpvar_21;
  tmpvar_21 = max (min ((
    ((xlv_COLOR1.y * f_2) * (tmpvar_10.y + 0.5))
   * 3.0), 1.0), _MinAlpha);
  outColor_7.w = tmpvar_21;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_22;
    scrpos_22 = xlv_TEXCOORD5;
    mediump float a_23;
    a_23 = xlv_TEXCOORD5.z;
    if ((a_23 < 0.95)) {
      scrpos_22.xy = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) * _ScreenParams.xy);
      a_23 = (a_23 * 17.0);
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_22.y / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_22.x / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float x_30;
      x_30 = ((a_23 - _DITHERMATRIX[
        int(tmpvar_26)
      ][
        int(tmpvar_29)
      ]) - 0.01);
      if ((x_30 < 0.0)) {
        discard;
      };
    };
  };
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FringeBumpTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _FringeViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _FringeBumpTex_ST.xy) + _FringeBumpTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _FringeViewDistance));
  adjCamPos_1 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((adjCamPos_1 - (unity_ObjectToWorld * _glesVertex).xyz));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = -(normalize((_glesNormal * tmpvar_14)));
  highp vec3 tmpvar_15;
  tmpvar_15.z = 0.0;
  tmpvar_15.x = tmpvar_5.y;
  tmpvar_15.y = -(tmpvar_5.x);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_15);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((tmpvar_5.yzx * tmpvar_16.zxy) - (tmpvar_5.zxy * tmpvar_16.yzx)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_12.zw;
    tmpvar_7.xyw = o_18.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD3 = tmpvar_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _FringeBumpTex;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _FringeTex;
uniform highp float _FringeIntensity;
uniform highp float _FringeBumpScaler;
uniform highp float _FringeRangeScaler;
uniform highp float _FringeRangeOffset;
uniform mediump vec4 _FringeFresnel;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 fringeColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  highp vec3 bumpVector_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz;
  baseTexColor_6 = tmpvar_8;
  outColor_7.xyz = ((baseTexColor_6 * _Color.xyz) * _EnvColor.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (texture2D (_FringeBumpTex, xlv_TEXCOORD0.zw).xyz - vec3(0.5, 0.5, 0.0));
  bumpVector_5 = tmpvar_9;
  bumpVector_5.xy = (bumpVector_5.xy * _FringeBumpScaler);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(bumpVector_5);
  bumpVector_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = abs(dot ((
    ((xlv_TEXCOORD2 * tmpvar_10.x) + (xlv_TEXCOORD3 * tmpvar_10.y))
   + 
    (xlv_TEXCOORD4 * tmpvar_10.z)
  ), normalize(xlv_TEXCOORD1)));
  cs_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(((tmpvar_12 * _FringeRangeScaler) + _FringeRangeOffset));
  uv_3 = tmpvar_13;
  highp float tmpvar_14;
  highp float cs_15;
  cs_15 = cs_4;
  highp float power_16;
  power_16 = _FringeFresnel.x;
  highp float scale_17;
  scale_17 = _FringeFresnel.y;
  highp float bias_18;
  bias_18 = _FringeFresnel.z;
  tmpvar_14 = (bias_18 + (pow (
    clamp ((1.0 - cs_15), 0.0, 1.0)
  , power_16) * scale_17));
  f_2 = tmpvar_14;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FringeTex, uv_3);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_19 * _FringeIntensity) * f_2) * (tmpvar_10.y + 0.5)).xyz;
  fringeColor_1 = tmpvar_20;
  outColor_7.xyz = ((outColor_7.xyz + fringeColor_1) - (outColor_7.xyz * fringeColor_1));
  outColor_7.xyz = (outColor_7.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  highp float tmpvar_21;
  tmpvar_21 = max (min ((
    ((xlv_COLOR1.y * f_2) * (tmpvar_10.y + 0.5))
   * 3.0), 1.0), _MinAlpha);
  outColor_7.w = tmpvar_21;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_22;
    scrpos_22 = xlv_TEXCOORD5;
    mediump float a_23;
    a_23 = xlv_TEXCOORD5.z;
    if ((a_23 < 0.95)) {
      scrpos_22.xy = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) * _ScreenParams.xy);
      a_23 = (a_23 * 17.0);
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_22.y / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_22.x / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float x_30;
      x_30 = ((a_23 - _DITHERMATRIX[
        int(tmpvar_26)
      ][
        int(tmpvar_29)
      ]) - 0.01);
      if ((x_30 < 0.0)) {
        discard;
      };
    };
  };
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _FringeBumpTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _FringeViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec4 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _FringeBumpTex_ST.xy) + _FringeBumpTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _FringeViewDistance));
  adjCamPos_1 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((adjCamPos_1 - (unity_ObjectToWorld * _glesVertex).xyz));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesVertex.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  tmpvar_5 = -(normalize((_glesNormal * tmpvar_14)));
  highp vec3 tmpvar_15;
  tmpvar_15.z = 0.0;
  tmpvar_15.x = tmpvar_5.y;
  tmpvar_15.y = -(tmpvar_5.x);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_15);
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(((tmpvar_5.yzx * tmpvar_16.zxy) - (tmpvar_5.zxy * tmpvar_16.yzx)));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_12.zw;
    tmpvar_7.xyw = o_18.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_16;
  xlv_TEXCOORD3 = tmpvar_17;
  xlv_TEXCOORD4 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _FringeBumpTex;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _FringeTex;
uniform highp float _FringeIntensity;
uniform highp float _FringeBumpScaler;
uniform highp float _FringeRangeScaler;
uniform highp float _FringeRangeOffset;
uniform mediump vec4 _FringeFresnel;
uniform highp float _UsingDitherAlpha;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 fringeColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  highp vec3 bumpVector_5;
  mediump vec3 baseTexColor_6;
  mediump vec4 outColor_7;
  outColor_7.w = 0.0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy).xyz;
  baseTexColor_6 = tmpvar_8;
  outColor_7.xyz = ((baseTexColor_6 * _Color.xyz) * _EnvColor.xyz);
  lowp vec3 tmpvar_9;
  tmpvar_9 = (texture2D (_FringeBumpTex, xlv_TEXCOORD0.zw).xyz - vec3(0.5, 0.5, 0.0));
  bumpVector_5 = tmpvar_9;
  bumpVector_5.xy = (bumpVector_5.xy * _FringeBumpScaler);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(bumpVector_5);
  bumpVector_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = abs(dot ((
    ((xlv_TEXCOORD2 * tmpvar_10.x) + (xlv_TEXCOORD3 * tmpvar_10.y))
   + 
    (xlv_TEXCOORD4 * tmpvar_10.z)
  ), normalize(xlv_TEXCOORD1)));
  cs_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_13;
  tmpvar_13 = vec2(((tmpvar_12 * _FringeRangeScaler) + _FringeRangeOffset));
  uv_3 = tmpvar_13;
  highp float tmpvar_14;
  highp float cs_15;
  cs_15 = cs_4;
  highp float power_16;
  power_16 = _FringeFresnel.x;
  highp float scale_17;
  scale_17 = _FringeFresnel.y;
  highp float bias_18;
  bias_18 = _FringeFresnel.z;
  tmpvar_14 = (bias_18 + (pow (
    clamp ((1.0 - cs_15), 0.0, 1.0)
  , power_16) * scale_17));
  f_2 = tmpvar_14;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_FringeTex, uv_3);
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_19 * _FringeIntensity) * f_2) * (tmpvar_10.y + 0.5)).xyz;
  fringeColor_1 = tmpvar_20;
  outColor_7.xyz = ((outColor_7.xyz + fringeColor_1) - (outColor_7.xyz * fringeColor_1));
  outColor_7.xyz = (outColor_7.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  highp float tmpvar_21;
  tmpvar_21 = max (min ((
    ((xlv_COLOR1.y * f_2) * (tmpvar_10.y + 0.5))
   * 3.0), 1.0), _MinAlpha);
  outColor_7.w = tmpvar_21;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_22;
    scrpos_22 = xlv_TEXCOORD5;
    mediump float a_23;
    a_23 = xlv_TEXCOORD5.z;
    if ((a_23 < 0.95)) {
      scrpos_22.xy = ((xlv_TEXCOORD5.xy / xlv_TEXCOORD5.w) * _ScreenParams.xy);
      a_23 = (a_23 * 17.0);
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_22.y / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_22.x / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float x_30;
      x_30 = ((a_23 - _DITHERMATRIX[
        int(tmpvar_26)
      ][
        int(tmpvar_29)
      ]) - 0.01);
      if ((x_30 < 0.0)) {
        discard;
      };
    };
  };
  outColor_7.w = clamp (outColor_7.w, 0.0, 1.0);
  gl_FragData[0] = outColor_7;
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
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 89964
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