//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar_Spectrum" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle] _UsingMainTexAlphaAsMask ("Using Main Tex Alpha As Mask", Float) = 0
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_SpectrumTex ("Spectrum Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_MinAlpha ("Min Alpha", Range(0, 1)) = 0
_OpaquenessScalerWithoutHDR ("", Float) = 1
_EmissionScaler ("Emission Scaler", Range(1, 20)) = 1
_EmissionScalerScalerWithoutHDR ("", Float) = 1
_SpectrumIntensity ("Spectrum Intensity", Range(0, 10)) = 1
_SpectrumRangeScaler ("Spectrum Range Scaler", Range(0, 10)) = 1
_SpectrumRangeOffset ("Spectrum Range Offset", Range(0, 1)) = 0
_SpectrumViewDistance ("Spectrum View Distance", Float) = 5
_SpectrumFresnel ("Spectrum Fresnel", Vector) = (1,1,0,0)
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 64969
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
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _SpectrumViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _SpectrumViewDistance));
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
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_12.zw;
    tmpvar_7.xyw = o_15.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform highp float _UsingMainTexAlphaAsMask;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _SpectrumTex;
uniform highp float _SpectrumIntensity;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform mediump vec4 _SpectrumFresnel;
uniform highp float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 SpectrumColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  mediump vec4 allChannel_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  allChannel_5 = tmpvar_7;
  outColor_6.xyz = ((allChannel_5.xyz * _Color.xyz) * _EnvColor.xyz);
  highp float tmpvar_8;
  tmpvar_8 = abs(dot (normalize(xlv_TEXCOORD2), normalize(xlv_TEXCOORD1)));
  cs_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_10;
  tmpvar_10 = vec2(((tmpvar_9 * _SpectrumRangeScaler) + _SpectrumRangeOffset));
  uv_3 = tmpvar_10;
  highp float tmpvar_11;
  highp float cs_12;
  cs_12 = cs_4;
  highp float power_13;
  power_13 = _SpectrumFresnel.x;
  highp float scale_14;
  scale_14 = _SpectrumFresnel.y;
  highp float bias_15;
  bias_15 = _SpectrumFresnel.z;
  tmpvar_11 = (bias_15 + (pow (
    clamp ((1.0 - cs_12), 0.0, 1.0)
  , power_13) * scale_14));
  f_2 = tmpvar_11;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpectrumTex, uv_3);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * _SpectrumIntensity) * f_2).xyz;
  SpectrumColor_1 = tmpvar_17;
  if (bool(_UsingMainTexAlphaAsMask)) {
    SpectrumColor_1 = (SpectrumColor_1 * allChannel_5.w);
  };
  outColor_6.xyz = ((outColor_6.xyz + SpectrumColor_1) - (outColor_6.xyz * SpectrumColor_1));
  outColor_6.xyz = (outColor_6.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  outColor_6.w = max (min ((
    (xlv_COLOR1.y * f_2)
   * 3.0), 1.0), _MinAlpha);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_18;
    scrpos_18 = xlv_TEXCOORD3;
    mediump float a_19;
    a_19 = xlv_TEXCOORD3.z;
    if ((a_19 < 0.95)) {
      scrpos_18.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_19 = (a_19 * 17.0);
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_18.y / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_18.x / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float x_26;
      x_26 = ((a_19 - _DITHERMATRIX[
        int(tmpvar_22)
      ][
        int(tmpvar_25)
      ]) - 0.01);
      if ((x_26 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _SpectrumViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _SpectrumViewDistance));
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
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_12.zw;
    tmpvar_7.xyw = o_15.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform highp float _UsingMainTexAlphaAsMask;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _SpectrumTex;
uniform highp float _SpectrumIntensity;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform mediump vec4 _SpectrumFresnel;
uniform highp float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 SpectrumColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  mediump vec4 allChannel_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  allChannel_5 = tmpvar_7;
  outColor_6.xyz = ((allChannel_5.xyz * _Color.xyz) * _EnvColor.xyz);
  highp float tmpvar_8;
  tmpvar_8 = abs(dot (normalize(xlv_TEXCOORD2), normalize(xlv_TEXCOORD1)));
  cs_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_10;
  tmpvar_10 = vec2(((tmpvar_9 * _SpectrumRangeScaler) + _SpectrumRangeOffset));
  uv_3 = tmpvar_10;
  highp float tmpvar_11;
  highp float cs_12;
  cs_12 = cs_4;
  highp float power_13;
  power_13 = _SpectrumFresnel.x;
  highp float scale_14;
  scale_14 = _SpectrumFresnel.y;
  highp float bias_15;
  bias_15 = _SpectrumFresnel.z;
  tmpvar_11 = (bias_15 + (pow (
    clamp ((1.0 - cs_12), 0.0, 1.0)
  , power_13) * scale_14));
  f_2 = tmpvar_11;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpectrumTex, uv_3);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * _SpectrumIntensity) * f_2).xyz;
  SpectrumColor_1 = tmpvar_17;
  if (bool(_UsingMainTexAlphaAsMask)) {
    SpectrumColor_1 = (SpectrumColor_1 * allChannel_5.w);
  };
  outColor_6.xyz = ((outColor_6.xyz + SpectrumColor_1) - (outColor_6.xyz * SpectrumColor_1));
  outColor_6.xyz = (outColor_6.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  outColor_6.w = max (min ((
    (xlv_COLOR1.y * f_2)
   * 3.0), 1.0), _MinAlpha);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_18;
    scrpos_18 = xlv_TEXCOORD3;
    mediump float a_19;
    a_19 = xlv_TEXCOORD3.z;
    if ((a_19 < 0.95)) {
      scrpos_18.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_19 = (a_19 * 17.0);
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_18.y / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_18.x / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float x_26;
      x_26 = ((a_19 - _DITHERMATRIX[
        int(tmpvar_22)
      ][
        int(tmpvar_25)
      ]) - 0.01);
      if ((x_26 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _SpectrumViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _SpectrumViewDistance));
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
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_12 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_12.zw;
    tmpvar_7.xyw = o_15.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform highp float _UsingMainTexAlphaAsMask;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _SpectrumTex;
uniform highp float _SpectrumIntensity;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform mediump vec4 _SpectrumFresnel;
uniform highp float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 SpectrumColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  mediump vec4 allChannel_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  allChannel_5 = tmpvar_7;
  outColor_6.xyz = ((allChannel_5.xyz * _Color.xyz) * _EnvColor.xyz);
  highp float tmpvar_8;
  tmpvar_8 = abs(dot (normalize(xlv_TEXCOORD2), normalize(xlv_TEXCOORD1)));
  cs_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_10;
  tmpvar_10 = vec2(((tmpvar_9 * _SpectrumRangeScaler) + _SpectrumRangeOffset));
  uv_3 = tmpvar_10;
  highp float tmpvar_11;
  highp float cs_12;
  cs_12 = cs_4;
  highp float power_13;
  power_13 = _SpectrumFresnel.x;
  highp float scale_14;
  scale_14 = _SpectrumFresnel.y;
  highp float bias_15;
  bias_15 = _SpectrumFresnel.z;
  tmpvar_11 = (bias_15 + (pow (
    clamp ((1.0 - cs_12), 0.0, 1.0)
  , power_13) * scale_14));
  f_2 = tmpvar_11;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SpectrumTex, uv_3);
  highp vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_16 * _SpectrumIntensity) * f_2).xyz;
  SpectrumColor_1 = tmpvar_17;
  if (bool(_UsingMainTexAlphaAsMask)) {
    SpectrumColor_1 = (SpectrumColor_1 * allChannel_5.w);
  };
  outColor_6.xyz = ((outColor_6.xyz + SpectrumColor_1) - (outColor_6.xyz * SpectrumColor_1));
  outColor_6.xyz = (outColor_6.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  outColor_6.w = max (min ((
    (xlv_COLOR1.y * f_2)
   * 3.0), 1.0), _MinAlpha);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_18;
    scrpos_18 = xlv_TEXCOORD3;
    mediump float a_19;
    a_19 = xlv_TEXCOORD3.z;
    if ((a_19 < 0.95)) {
      scrpos_18.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_19 = (a_19 * 17.0);
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_18.y / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_18.x / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float x_26;
      x_26 = ((a_19 - _DITHERMATRIX[
        int(tmpvar_22)
      ][
        int(tmpvar_25)
      ]) - 0.01);
      if ((x_26 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _SpectrumViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _SpectrumViewDistance));
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
  highp vec4 spuvs_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (_glesVertex * 0.5);
  spuvs_15.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.x + (tmpvar_16.z * tmpvar_16.z));
  tmpvar_17.y = ((tmpvar_16.y + (0.5 * tmpvar_16.z)) + ((0.5 * tmpvar_16.x) * tmpvar_16.x));
  spuvs_15.zw = ((tmpvar_17 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = spuvs_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform highp float _UsingMainTexAlphaAsMask;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _SpectrumTex;
uniform highp float _SpectrumIntensity;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform mediump vec4 _SpectrumFresnel;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec3 SpectrumColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  mediump vec4 allChannel_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  allChannel_5 = tmpvar_7;
  outColor_6.xyz = ((allChannel_5.xyz * _Color.xyz) * _EnvColor.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  highp float tmpvar_10;
  tmpvar_10 = abs(dot (tmpvar_8, tmpvar_9));
  cs_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_12;
  tmpvar_12 = vec2(((tmpvar_11 * _SpectrumRangeScaler) + _SpectrumRangeOffset));
  uv_3 = tmpvar_12;
  highp float tmpvar_13;
  highp float cs_14;
  cs_14 = cs_4;
  highp float power_15;
  power_15 = _SpectrumFresnel.x;
  highp float scale_16;
  scale_16 = _SpectrumFresnel.y;
  highp float bias_17;
  bias_17 = _SpectrumFresnel.z;
  tmpvar_13 = (bias_17 + (pow (
    clamp ((1.0 - cs_14), 0.0, 1.0)
  , power_15) * scale_16));
  f_2 = tmpvar_13;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_SpectrumTex, uv_3);
  highp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_18 * _SpectrumIntensity) * f_2).xyz;
  SpectrumColor_1 = tmpvar_19;
  if (bool(_UsingMainTexAlphaAsMask)) {
    SpectrumColor_1 = (SpectrumColor_1 * allChannel_5.w);
  };
  outColor_6.xyz = ((outColor_6.xyz + SpectrumColor_1) - (outColor_6.xyz * SpectrumColor_1));
  outColor_6.xyz = (outColor_6.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  outColor_6.w = max (min ((
    (xlv_COLOR1.y * f_2)
   * 3.0), 1.0), _MinAlpha);
  mediump vec3 wnormal_20;
  wnormal_20 = tmpvar_8;
  mediump vec3 wpos_21;
  wpos_21 = tmpvar_9;
  mediump vec3 reflection_22;
  mediump vec3 R_23;
  mediump float intensity_24;
  mediump vec4 noiseTex_25;
  mediump vec4 spColor_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_26 = tmpvar_27;
  spColor_26.w = (spColor_26.w * _SPOpaqueness);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_25 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = (((1.99 * tmpvar_28.x) * _SPNoiseScaler) - 1.0);
  intensity_24 = tmpvar_29;
  highp vec3 tmpvar_30;
  highp vec3 I_31;
  I_31 = ((normalize(
    (wpos_21 - _WorldSpaceCameraPos)
  ) + (noiseTex_25 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (wnormal_20, I_31)
   * wnormal_20)));
  R_23 = tmpvar_30;
  lowp vec3 tmpvar_32;
  tmpvar_32 = textureCube (_SPCubeMap, R_23).xyz;
  reflection_22 = tmpvar_32;
  highp vec3 tmpvar_33;
  mediump vec3 x_34;
  x_34 = (spColor_26.xyz * _SPOldColor.xyz);
  tmpvar_33 = mix (x_34, ((reflection_22 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_26.xyz = tmpvar_33;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_24 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_24 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_35;
      tmpvar_35 = mix (spColor_26.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_24) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_26.xyz = tmpvar_35;
    };
  };
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (outColor_6, spColor_26, vec4(xlat_mutable_SPIntensity));
  spColor_26 = tmpvar_36;
  outColor_6 = spColor_26;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD3;
    mediump float a_38;
    a_38 = xlv_TEXCOORD3.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (spColor_26.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _SpectrumViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _SpectrumViewDistance));
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
  highp vec4 spuvs_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (_glesVertex * 0.5);
  spuvs_15.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.x + (tmpvar_16.z * tmpvar_16.z));
  tmpvar_17.y = ((tmpvar_16.y + (0.5 * tmpvar_16.z)) + ((0.5 * tmpvar_16.x) * tmpvar_16.x));
  spuvs_15.zw = ((tmpvar_17 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = spuvs_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform highp float _UsingMainTexAlphaAsMask;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _SpectrumTex;
uniform highp float _SpectrumIntensity;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform mediump vec4 _SpectrumFresnel;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec3 SpectrumColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  mediump vec4 allChannel_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  allChannel_5 = tmpvar_7;
  outColor_6.xyz = ((allChannel_5.xyz * _Color.xyz) * _EnvColor.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  highp float tmpvar_10;
  tmpvar_10 = abs(dot (tmpvar_8, tmpvar_9));
  cs_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_12;
  tmpvar_12 = vec2(((tmpvar_11 * _SpectrumRangeScaler) + _SpectrumRangeOffset));
  uv_3 = tmpvar_12;
  highp float tmpvar_13;
  highp float cs_14;
  cs_14 = cs_4;
  highp float power_15;
  power_15 = _SpectrumFresnel.x;
  highp float scale_16;
  scale_16 = _SpectrumFresnel.y;
  highp float bias_17;
  bias_17 = _SpectrumFresnel.z;
  tmpvar_13 = (bias_17 + (pow (
    clamp ((1.0 - cs_14), 0.0, 1.0)
  , power_15) * scale_16));
  f_2 = tmpvar_13;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_SpectrumTex, uv_3);
  highp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_18 * _SpectrumIntensity) * f_2).xyz;
  SpectrumColor_1 = tmpvar_19;
  if (bool(_UsingMainTexAlphaAsMask)) {
    SpectrumColor_1 = (SpectrumColor_1 * allChannel_5.w);
  };
  outColor_6.xyz = ((outColor_6.xyz + SpectrumColor_1) - (outColor_6.xyz * SpectrumColor_1));
  outColor_6.xyz = (outColor_6.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  outColor_6.w = max (min ((
    (xlv_COLOR1.y * f_2)
   * 3.0), 1.0), _MinAlpha);
  mediump vec3 wnormal_20;
  wnormal_20 = tmpvar_8;
  mediump vec3 wpos_21;
  wpos_21 = tmpvar_9;
  mediump vec3 reflection_22;
  mediump vec3 R_23;
  mediump float intensity_24;
  mediump vec4 noiseTex_25;
  mediump vec4 spColor_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_26 = tmpvar_27;
  spColor_26.w = (spColor_26.w * _SPOpaqueness);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_25 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = (((1.99 * tmpvar_28.x) * _SPNoiseScaler) - 1.0);
  intensity_24 = tmpvar_29;
  highp vec3 tmpvar_30;
  highp vec3 I_31;
  I_31 = ((normalize(
    (wpos_21 - _WorldSpaceCameraPos)
  ) + (noiseTex_25 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (wnormal_20, I_31)
   * wnormal_20)));
  R_23 = tmpvar_30;
  lowp vec3 tmpvar_32;
  tmpvar_32 = textureCube (_SPCubeMap, R_23).xyz;
  reflection_22 = tmpvar_32;
  highp vec3 tmpvar_33;
  mediump vec3 x_34;
  x_34 = (spColor_26.xyz * _SPOldColor.xyz);
  tmpvar_33 = mix (x_34, ((reflection_22 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_26.xyz = tmpvar_33;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_24 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_24 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_35;
      tmpvar_35 = mix (spColor_26.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_24) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_26.xyz = tmpvar_35;
    };
  };
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (outColor_6, spColor_26, vec4(xlat_mutable_SPIntensity));
  spColor_26 = tmpvar_36;
  outColor_6 = spColor_26;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD3;
    mediump float a_38;
    a_38 = xlv_TEXCOORD3.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (spColor_26.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _OpaquenessScalerWithoutHDR;
uniform highp float _SpectrumViewDistance;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 adjCamPos_1;
  mediump vec3 d_2;
  highp vec4 localOrig_3;
  highp vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  mediump vec2 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_6.x = 0.0;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6.y = (_Opaqueness * _OpaquenessScalerWithoutHDR);
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0));
  localOrig_3 = (tmpvar_8 / tmpvar_8.w);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - localOrig_3.xyz));
  d_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (localOrig_3.xyz + (d_2 * _SpectrumViewDistance));
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
  highp vec4 spuvs_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (_glesVertex * 0.5);
  spuvs_15.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_17;
  tmpvar_17.x = (tmpvar_16.x + (tmpvar_16.z * tmpvar_16.z));
  tmpvar_17.y = ((tmpvar_16.y + (0.5 * tmpvar_16.z)) + ((0.5 * tmpvar_16.x) * tmpvar_16.x));
  spuvs_15.zw = ((tmpvar_17 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
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
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = spuvs_15;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform lowp samplerCube _SPCubeMap;
uniform highp vec3 _SPCubeMapOffset;
uniform highp float _SPCubeMapIntensity;
uniform highp float _SPCubeMapNoiseIntensity;
uniform highp float _SPCubeMapBrightness;
uniform mediump vec4 _SPOldColor;
uniform mediump vec4 _SPCubeMapColor;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform highp float _UsingMainTexAlphaAsMask;
uniform mediump float _MinAlpha;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionScalerScalerWithoutHDR;
uniform sampler2D _SpectrumTex;
uniform highp float _SpectrumIntensity;
uniform highp float _SpectrumRangeScaler;
uniform highp float _SpectrumRangeOffset;
uniform mediump vec4 _SpectrumFresnel;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec2 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump vec3 SpectrumColor_1;
  mediump float f_2;
  mediump vec2 uv_3;
  mediump float cs_4;
  mediump vec4 allChannel_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  allChannel_5 = tmpvar_7;
  outColor_6.xyz = ((allChannel_5.xyz * _Color.xyz) * _EnvColor.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(xlv_TEXCOORD2);
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD1);
  highp float tmpvar_10;
  tmpvar_10 = abs(dot (tmpvar_8, tmpvar_9));
  cs_4 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = (1.570796 - (sign(cs_4) * (1.570796 - 
    (sqrt((1.0 - abs(cs_4))) * (1.570796 + (abs(cs_4) * (-0.2146018 + 
      (abs(cs_4) * (0.08656672 + (abs(cs_4) * -0.03102955)))
    ))))
  )));
  highp vec2 tmpvar_12;
  tmpvar_12 = vec2(((tmpvar_11 * _SpectrumRangeScaler) + _SpectrumRangeOffset));
  uv_3 = tmpvar_12;
  highp float tmpvar_13;
  highp float cs_14;
  cs_14 = cs_4;
  highp float power_15;
  power_15 = _SpectrumFresnel.x;
  highp float scale_16;
  scale_16 = _SpectrumFresnel.y;
  highp float bias_17;
  bias_17 = _SpectrumFresnel.z;
  tmpvar_13 = (bias_17 + (pow (
    clamp ((1.0 - cs_14), 0.0, 1.0)
  , power_15) * scale_16));
  f_2 = tmpvar_13;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_SpectrumTex, uv_3);
  highp vec3 tmpvar_19;
  tmpvar_19 = ((tmpvar_18 * _SpectrumIntensity) * f_2).xyz;
  SpectrumColor_1 = tmpvar_19;
  if (bool(_UsingMainTexAlphaAsMask)) {
    SpectrumColor_1 = (SpectrumColor_1 * allChannel_5.w);
  };
  outColor_6.xyz = ((outColor_6.xyz + SpectrumColor_1) - (outColor_6.xyz * SpectrumColor_1));
  outColor_6.xyz = (outColor_6.xyz * (_EmissionScaler * _EmissionScalerScalerWithoutHDR));
  outColor_6.w = max (min ((
    (xlv_COLOR1.y * f_2)
   * 3.0), 1.0), _MinAlpha);
  mediump vec3 wnormal_20;
  wnormal_20 = tmpvar_8;
  mediump vec3 wpos_21;
  wpos_21 = tmpvar_9;
  mediump vec3 reflection_22;
  mediump vec3 R_23;
  mediump float intensity_24;
  mediump vec4 noiseTex_25;
  mediump vec4 spColor_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_26 = tmpvar_27;
  spColor_26.w = (spColor_26.w * _SPOpaqueness);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  noiseTex_25 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = (((1.99 * tmpvar_28.x) * _SPNoiseScaler) - 1.0);
  intensity_24 = tmpvar_29;
  highp vec3 tmpvar_30;
  highp vec3 I_31;
  I_31 = ((normalize(
    (wpos_21 - _WorldSpaceCameraPos)
  ) + (noiseTex_25 * _SPCubeMapNoiseIntensity).xyz) + _SPCubeMapOffset);
  tmpvar_30 = (I_31 - (2.0 * (
    dot (wnormal_20, I_31)
   * wnormal_20)));
  R_23 = tmpvar_30;
  lowp vec3 tmpvar_32;
  tmpvar_32 = textureCube (_SPCubeMap, R_23).xyz;
  reflection_22 = tmpvar_32;
  highp vec3 tmpvar_33;
  mediump vec3 x_34;
  x_34 = (spColor_26.xyz * _SPOldColor.xyz);
  tmpvar_33 = mix (x_34, ((reflection_22 * _SPCubeMapColor.xyz) * _SPCubeMapBrightness), vec3(_SPCubeMapIntensity));
  spColor_26.xyz = tmpvar_33;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_24 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_24 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_35;
      tmpvar_35 = mix (spColor_26.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_24) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_26.xyz = tmpvar_35;
    };
  };
  highp vec4 tmpvar_36;
  tmpvar_36 = mix (outColor_6, spColor_26, vec4(xlat_mutable_SPIntensity));
  spColor_26 = tmpvar_36;
  outColor_6 = spColor_26;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD3;
    mediump float a_38;
    a_38 = xlv_TEXCOORD3.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  outColor_6.w = clamp (spColor_26.w, 0.0, 1.0);
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 130088
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
 Pass {
  Name "COMPLEX"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 167575
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
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
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
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
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
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_12;
    highp vec4 tmpvar_13;
    tmpvar_13 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_14;
    tmpvar_14.x = tmpvar_13.x;
    tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
    o_12.xy = (tmpvar_14 + tmpvar_13.w);
    o_12.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_12.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
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
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
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
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
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
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
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
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec2 spnoiseuv_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (_glesVertex * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  spnoiseuv_12 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_15;
    highp vec4 tmpvar_16;
    tmpvar_16 = (tmpvar_3 * 0.5);
    highp vec2 tmpvar_17;
    tmpvar_17.x = tmpvar_16.x;
    tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
    o_15.xy = (tmpvar_17 + tmpvar_16.w);
    o_15.zw = tmpvar_3.zw;
    tmpvar_5.xyw = o_15.xyw;
    tmpvar_5.z = _DitherAlpha;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = spnoiseuv_12;
  xlv_TEXCOORD3 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  mediump float intensity_3;
  mediump vec4 outColor_4;
  outColor_4 = _SPOutlineColor;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_3 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_4 = xlv_COLOR0;
  };
  color_1.w = outColor_4.w;
  color_1.xyz = (outColor_4.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_7;
    scrpos_7 = xlv_TEXCOORD3;
    mediump float a_8;
    a_8 = xlv_TEXCOORD3.z;
    if ((a_8 < 0.95)) {
      scrpos_7.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
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
  color_1.w = clamp (outColor_4.w, 0.0, 1.0);
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
}
CustomEditor "MoleMole.CharacterShaderEditorBase"
}